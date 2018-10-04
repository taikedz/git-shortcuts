### gits push [REMOTE [BRANCH]] Usage:help-push
#
# Push to remote; if not set, automatically guess and set upstream
#
###/doc

gits:push() {
    gits:local-help push "$@"

    local remote branch localbranch pushargs
    pushargs=(push --set-upstream)
    localbranch="$(gits:current-branch)"

    [[ -n "$localbranch" ]] || out:fail "Could not get local branch !"

    if [[ -z "$*" ]]; then
        gits:run "${pushargs[@]}" origin "$localbranch"
        return
    fi

    remote="$1"; shift

    gits:remote-exists "$remote" || out:fail "No such remote '$remote'"

    if [[ -z "$*" ]]; then
        gits:run "${pushargs[@]}" "$remote" "$localbranch"
    else
        branch="$1"; shift

        gits:run "${pushargs[@]}" "$remote" "$branch"
    fi
}
