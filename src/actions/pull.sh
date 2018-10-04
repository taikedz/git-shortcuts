### pull backtrack [N] Usage:help
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
    local action="${1:-}" ; shift || :
    case "$action" in
    backtrack)
        gits:pull:backtrack "$@"
        ;;
    *)
        out:fail "No subaction specified"
        ;;
    esac
}

gits:pull:backtrack() {
    local back_by="${1:-}"; shift || :

    if [[ -n "$back_by" ]]; then
        [[ "$back_by" =~ $PAT_num ]] || out:fail "NaN: $back_by"
        gits:run reset --hard HEAD~$back_by

    else
        while git status | grep -q diverged; do
            git reset --hard HEAD~1
        done

    fi

    gits:run log --graph --oneline --all -n10

    askuser:confirm "Pull now ?" || exit 1

    gits:run pull
}
