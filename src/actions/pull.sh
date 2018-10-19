### pull [backtrack [N]] Usage:help-pull
#
# gits pull
# ---------
#
# With no options, performs a fetch and checks for fast-forwardability.
#
# If the remote branch is simply ahead, the local branch will be fast-forwarded.
#
# If the branches have diverged, no pull is performed and a warning is printed.
#
# gits pull backtrack [N]
# -----------------------
#
# If your local and remote branches have diverged due to upstream having rebased, do a backtrack.
#
#   gits pull backtrack 5
#
# revert 5 commits, then pull
#
#   gits pull backtrack
#
# reverts each commit one by one until no longer on a divergent path
#
###/doc

#%include patterns.sh

gits:pull:_dispatch() {
    gits:local-help pull "$@"

    local action="${1:-}" ; shift || :

    if [[ -z "$action" ]]; then
        gits:pull:checking
        return
    fi

    case "$action" in
    backtrack)
        gits:pull:backtrack "$@"
        ;;
    *)
        out:fail "No subaction specified"
        ;;
    esac
}

gits:pull:checking() {
    gits:run fetch --all
    
    if git status | grep -qP "^Changes|^Untracked"; then
        gits:run status -sb
        out:fail "Changes detected, cannot pull"

    elif git status | grep -qP "^Your branch is (up to date|up-to-date)"; then
        gits:status:short
        echo
        out:info "Everything up to date"

    elif git status | grep -qP "^Your branch.+can be fast-forwarded"; then

        gits:run pull

    elif gits:branch:show-upstream | grep -qP ' \(none\)$'; then
        out:fail "No remote detected"

    else
        gits:run status -uall
        echo
        out:fail "Unsure whether to pull yet."

    fi
}

gits:pull:backtrack() {
    local back_by="${1:-}"; shift || :
    local headnum

    if [[ -n "$back_by" ]]; then
        [[ "$back_by" =~ $PAT_num ]] || out:fail "NaN: $back_by"
        gits:run reset --hard HEAD~$back_by

    else
        while git status | grep -q diverged; do
            git reset --hard HEAD~1
        done

    fi

    headnum="$(git log --graph --oneline --all --decorate=short |grep '(HEAD ->' -n|cut -f1 -d:)"

    gits:run log --graph --oneline --all -n${headnum}

    askuser:confirm "Pull now ?" || exit 1

    gits:run pull
}
