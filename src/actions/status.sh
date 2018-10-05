gits:status:short() {
    local dirs=(: "$@")
    local d

    [[ -n "${dirs[@]:1}" ]] || dirs=(: .)

    for d in "${dirs[@]:1}"; do
        (cd "$d"
        out:info "$PWD"
        gits:run status -sb -uall
        )
    done
}

gits:status:fetch() {
    local dirs=(: "$@")
    local d

    [[ -n "${dirs[@]:1}" ]] || dirs=(: .)

    for d in "${dirs[@]:1}"; do
        (cd "$d"
        out:info "$PWD"
        gits:run fetch --all
        gits:run status -uall
        )
    done
}

