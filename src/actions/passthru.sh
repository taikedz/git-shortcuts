GITS_PASSTHRU_COMMANDS=(
    add
#    branch
#    checkout
#    clean
#    clone
#    diff
#    log
#    pull
#    push
#    remote
#    status
    mv
    reset
    rm
    bisect
    grep
    show
    merge
#    rebase
    tag
    fetch
    init
    stash
)

$%function gits:passthru:check(keyword) {
    local command
    for command in "${GITS_PASSTHRU_COMMANDS[@]}"; do
        if [[ "$command" = "$keyword" ]]; then
            return 0
        fi
    done
    return 1
}

gits:passthru:run() {
    /usr/bin/env git "$@"
}
