### diff FILE ... Usage:help-diff
# Display diff of each file
###/doc

gits:check-commit() {
    local x
    for x in "$@"; do
        if [[ "$x" =~ ^-mm?$ ]]; then
            return 1
        fi
    done

    return 0
}

gits:diff() {
    gits:check-commit "$@" || {
        gits:commit "$@"
        return
    }

    echo "Diffs for: $*"

    gits:local-help-noempty diff "$@"

    local item

    for item in "$@"; do
        gits:run diff --color HEAD -- "$item" |gits:diff:report-empty "$item"| less -R
    done
}

gits:diff:report-empty() {
    local i=0
    while read; do
        echo "$REPLY"
        ((i+=1))
    done
    if [[ "$i" = 0 ]]; then
        echo "${CYEL}No changes on '$1'${CDEF}"
        return 1
    fi
}
