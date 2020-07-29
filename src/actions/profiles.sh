#%include std/ensureline.sh
#%include std/varify.sh
#%include std/readkv.sh

### gits profile Usage:help-profile
#
# Save user/email configurations, apply them, manage them
#
# gits profile
#   Display the user name and email currently configured on the repo
#
# gits profile list
#   Display the defined profiles
#
# gits profile get PROFILE
#   Display the settings for specified profile
# 
# gits profile delete PROFILE
#   Delete a saved profile
#
# gits profile save PROFILE USER_NAME EMAIL
#   Save user name and email to the named profile
#
# gits profile apply PROFILE
#   Configure the repo to use the specified profile
#
###/doc

## todo
# gits profile profilename user.name="User Name" user.email="mail@domain.tld" diff.tool=meld comit.editor=vim
#
# save literal config names->values to the key file
# iterate over config to apply
# allow a `profile edit` command

gits:profiles:_dispatch() {
    gits:local-help profile "$@"

    local action
    if [[ -z "$*" ]]; then
        echo "Current config:"
        echo "  Name:  $(git config user.name)"
        echo "  Email: $(git config user.email)"

    else
        action="${1:-}" ; shift || :
        case "$action" in
        save|get|delete|list|apply)
            gits:profiles:"$action" "$@"
            ;;
        *)
            out:fail "Unknown action"
        esac
    fi
}

gits:profiles:get() {
    local profiled profilename
    profilename="$(varify:fil "${1:-}")"; shift || out:fail "No profile name specified"
    profilef="$(gits:store:get-file profiles/$profilename.txt)"

    [[ -f "$profilef" ]] || out:fail "No such profile '$profilename'"

    gits:profiles:display "$profilef"
}

gits:profiles:delete() {
    local profiled profilename
    profilename="$(varify:fil "${1:-}")"; shift || out:fail "No profile name specified"
    profilef="$(gits:store:get-file profiles/$profilename.txt)"

    [[ -f "$profilef" ]] || out:fail "No such profile '$profilename'"

    if [[ "$GITS_no_ask_profile_delte" != true ]]; then
        askuser:confirm "Delete '$profilename'?" || return
    fi
    rm "$profilef"
}

gits:profiles:display() {
    sed -r 's/^/\t/' "$1"
}

gits:profiles:apply() {
    local profiled profilename uname umail
    profilename="$(varify:fil "${1:-}")"; shift || out:fail "No profile name specified"
    profilef="$(gits:store:get-file profiles/$profilename.txt)"

    [[ -f "$profilef" ]] || out:fail "No such profile '$profilename'"

    uname="$(readkv:require Name "$profilef")" #|| out:fail "Name could not be read"
    umail="$(readkv:require Mail "$profilef")" #|| out:fail "Mail could not be read"

    gits:run config user.name "$uname"
    gits:run config user.email "$umail"
}

gits:profiles:save() {
    local profiled profilename username useremail
    profilename="$(varify:fil "${1:-}")"; shift || out:fail "No profile name specified"
    username="${1:-}"; shift || out:fail "No user name specified"
    useremail="${1:-}"; shift || out:fail "No user email specified"
    
    profilef="$(gits:store:create-get-file profiles/$profilename.txt)"
    echo -e "Name=$username\nMail=$useremail" > "$profilef"
}

gits:profiles:list() {
    local profiled pfile sname
    profiled="$(gits:store:get-dir profiles)"

    for pfile in "$profiled/"*.txt ; do
        sname="${pfile##*/}"
        sname="${sname%.*}"

        echo "$sname"
        gits:profiles:display "$pfile"
    done
}
