#%include ensureline.sh varify.sh readkv.sh

gits:profiles:_dispatch() {
    local action
    action="${1:-}" ; shift || :
    case "$action" in
    get|delete|list|apply)
        gits:profiles:"$action" "$@"
        ;;
    *)
        echo "Current config:"
        git config user.name
        git config user.email
        ;;
    esac
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

    askuser:confirm "Delete '$profilename'?" || return
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

    git config user.name "$uname"
    git config user.email "$umail"
}

gits:profiles:put() {
    local profiled profilename username useremail
    profilename="$(varify:fil "${1:-}")"; shift || out:fail "No profile name specified"
    profilef="$(gits:store:create-get-file profiles/$profilename.txt)"

    username="${1:-}"; shift || out:fail "No user name specified"
    useremail="${1:-}"; shift || out:fail "No user email specified"
    
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