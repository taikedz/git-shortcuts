#%include askuser.sh

### Commit -m[m] [MESSAGE] Usage:help-commit
#
# After a series of items, if -m or -mm are found, performs an add + commit
#
# -m adds a new commit
# -mm amends the last commit
#
# if no MESSAGE is suppplied, an editor session is started
#
###/doc

gits:commit() {
    gits:commit:check_master

    # need to add help that does not catch --help as part of message
    local files item arguments
    files=()
    arguments=()
    item="$1"

    while [[ ! "$item" =~ ^-mm?$ ]]; do
        files+=("$item")
        shift
        item="$1"
    done
    shift

    if [[ "$item" = -mm ]]; then
        arguments+=(--amend)
    fi

    if [[ -n "$*" ]]; then
        arguments+=(-m "$*")
    fi

    git add "${files[@]}"
    git commit "${arguments[@]}"
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
