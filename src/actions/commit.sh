#%include askuser.sh

### Commit: gits [FILES] -m[m|/PROFILE] [MESSAGE] Usage:help-commit
#
# After a series of files, if -m or -mm are found, performs an add + commit
#
# -m adds a new commit
# -mm amends the last commit
#
# if no MESSAGE is suppplied, an editor session is started
#
# if `/PROFILE` is set, commits using user details from the relevant profile, then reverts the details
#   /PROFILE cannot be used when amending.
#
# If the current branch is master, and `allow_master_commits` in .gits-shorthands is not set,
#   then prompt the user whether to allow.
#   When set to `true`, never prompts and allows comitting to master
#   When set to `false`, never prompts and prevents comitting to master
#
###/doc

GITS_commitflag="^-m(m|/([a-zA-Z_-]+))?$"

gits:commit:check() {
    local x
    for x in "$@"; do
        if [[ "$x" =~ $GITS_commitflag ]]; then
            return 1
        elif [[ "$x" =~ ^-mm/ ]]; then
            out:fail "Cannot change profile when amending a commit. Reset and re-commit."
        fi
    done

    return 0
}

gits:commit() {
    gits:local-help commit "$@"

    gits:commit:check_master

    # need to add help that does not catch --help as part of message
    local files item arguments
    files=(:)
    arguments=(:)
    item="$1"

    while [[ ! "$item" =~ $GITS_commitflag ]]; do
        files+=("$item")
        shift
        item="$1"
    done
    shift

    GITS_profile_switch="${BASH_REMATCH[2]:-}"

    if [[ "$item" =~ ^-mm ]]; then
        arguments+=(--amend)
    fi

    if [[ -n "$*" ]]; then
        arguments+=(-m "$*")
    fi

    if [[ -n "${files[*]:1}" ]]; then
        gits:run add "${files[@]:1}"
    fi

    if [[ -n "${GITS_profile_switch:-}" ]]; then
        configname="$(git config user.name)"
        configmail="$(git config user.email)"
        gits:profiles:save temp "$configname" "$configmail"
        gits:profiles:apply "$GITS_profile_switch"
    fi

    gits:run commit "${arguments[@]:1}" || :

    if [[ -n "${GITS_profile_switch:-}" ]]; then
        gits:commit:profile-restore
    fi
}

gits:commit:profile-restore() {
    gits:profiles:apply temp
}

gits:commit:check_master() {
    local onbranch allowmaster setting
    setting=allow_master_commits
    onbranch="$(git status | head -n1 | grep -oP '(?<=On branch )[^\s]+')"
    allowmaster="$(gits:prefs:get "$setting")"

    if [[ "$onbranch" = master ]]; then
        if [[ "$allowmaster" = false ]]; then
            out:fail "You must not commit on master. Try moving your changes with 'git stash' and 'git checkout' before comitting again."

        elif [[ "$allowmaster" = true ]]; then
            return 0

        else
            if askuser:confirm "${CYEL}You are comitting on master - continue ?${CDEF}"; then
                gits:prefs:advise "$setting" "true"
                return 0
            fi
            gits:prefs:advise "$setting" "false"
            out:fail "Abort"
        fi
    fi

    return 0
}
