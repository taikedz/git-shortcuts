gits:common:fetch-status() {
    git fetch
    git status
}

gits:local-help() {
    local section="$1"; shift

    if [[ -z "$*" ]] || [[ "$*" =~ --help ]]; then
        autohelp:print "help-$section"
        exit 0
    fi
}
