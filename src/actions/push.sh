gits:push() {
    local remote branch localbranch gitpush
    gitpush=(git push --set-upstream)
    localbranch="$(gits:current-branch)"

    [[ -n "$localbranch" ]] || out:fail "Could not get local branch !"

    if [[ -z "$*" ]]; then
        "${gitpush[@]}" origin "$localbranch"
        return
    fi

    remote="$1"; shift

    gits:remote-exists "$remote" || out:fail "No such remote '$remote'"

    if [[ -z "$*" ]]; then
        "${gitpush[@]}" "$remote" "$localbranch"
    else
        branch="$1"; shift

        "${gitpush[@]}" "$remote" "$branch"
    fi
}
