### gits clone URL [PATH] Usage:help-clone
#
# Clone a git URL, creating intermediary directories.
#
# If DIRECTORY is not specified:
#
# * URL is parsed assuming presence of a domain name - this is detected by a `user@domain` or `scheme://domain` pattern
# * Group/user name and repo name are detected as being at the end of the URL as `name/repo(.git)?`
#
# The clone then creates directories `domain/name/repo` and clones to it.
#
# If DIRECTORY is specified:
#
# All intermediary directories are created, then the clone is performed to that location.
#
###/doc

$%function gits:clone:_dispatch(?url ?directory) {

    gits:local-help-no-empty clone "$url" "$@"

    if [[ -z "$directory" ]]; then
        local domain user repo
        gits:clone:_valid-url "$url"
        gits:clone:get-components domain user repo "$url"

        ([[ -n "$domain" ]] && [[ -n "$user" ]] && [[ "$repo" ]]) || out:fail "Failed to parse URL"

        mkdir -p "$domain/$user"
    else
        mkdir -p "$directory"
    fi

    gits:run clone "$url" "$domain/$user/$repo"
}

$%function gits:clone:get-components(v_domain v_user v_repo url) {
    local -n p_domain p_user p_repo
    p_domain=$v_domain
    p_user=$v_user
    p_repo=$v_repo

    p_domain="$(echo "$url"|sed -r -e 's#^([a-zA-Z0-9]+://)?([a-zA-Z0-9]+@)?##' -e 's#([^/:]+?).+#\1#')"
    read p_user p_repo < <(echo "$url"|sed -r -e 's#.+[:/]([^/]+)/([^/]+)(\.git)?$#\1 \2#')
}

$%function gits:clone:_valid-url(url) {
    ( [[ ! "$url" =~ \.\. ]] && ([[ "$url" =~ ^[a-z]+://[a-z] ]] || [[ "$url" =~ [a-zA-Z0-9_]+@[a-zA-Z] ]]) ) || out:fail "Invalid URL requested"
}
