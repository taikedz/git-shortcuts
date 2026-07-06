gits:root() {
    topdir="$(readlink -f $(pwd))"
    gitdir="$topdir"
    while [[ "$gitdir" != / ]]; do
        if [[ -f "$gitdir/.git/config" ]]; then
            echo "$gitdir"
            return 0
        fi
        gitdir="$(dirname "$gitdir")"
    done
    out:warn "$topdir is not under a git repository"
    return 1
}
