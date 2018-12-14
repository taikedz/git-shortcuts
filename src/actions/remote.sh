#%include std/askuser.sh

### remote [ACTION ...] Usage:help-remote
#
# Display data for remotes, or perfrom rename/assignment options
#
# gits remote ls
#   list remotes and their URLs
#
# gits remote set REMOTE URL
#   Assign URL to REMOTE
#   If the remote does not exist, user is prompted before creating it.
#
# gits remote sub REMOTE SUBSTITUTION ...
#   perform a substitution SUBSTITUTION on remote REMOTE
#   SUBSTITUTION is a `sed` substitution string
#   E.g. : gits remote sub origin "s|github.com/me|gitlab.com/myself|"
#
###/doc

$%function gits:remote:_dispatch(?action) {
    gits:local-help remote "$action" "$@"

    [[ -n "$action" ]] || {
        gits:remote:list
        exit
    }

    case "$action" in
    ls|list)
        gits:remote:list
        ;;
    sub)
        gits:remote:sub "$@"
        ;;
    set|set-url)
        gits:remote:set-url "$@"
        ;;
    esac
}

$%function gits:remote:sub(remote sub) {
    local remote_url

    remote_url="$(git remote get-url "$remote")"
    [[ -n "$remote_url" ]] || out:fail "No URL for '$remote'"

    gits:run remote set-url "$remote" "$(echo "$remote_url"|sed -r -e "$sub")"
}

gits:remote:list() {
    git remote | while read remote; do
        echo "$remote : $(git remote get-url "$remote")"
    done
}

$%function gits:remote:set-url(remote url) {
    if git remote | grep -Eq "^$remote$" ; then
        gits:run remote set-url "$remote" "$url"
    else
        askuser:confirm "Create new remote '$remote' poitning to '$url' ?" || exit
        gits:run remote add "$remote" "$url"
    fi
}
