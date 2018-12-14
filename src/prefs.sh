#%include std/readkv.sh
#%include std/ensureline.sh

gits:prefs:get() {
    local prefsfile setting
    setting="${1:-}" ; shift || out:fail "No setting provided"
    prefsfile="$(gits:prefs:filepath)"

    if [[ -f "$prefsfile" ]]; then
        readkv "$setting" "$prefsfile" "$*"
    else
        [[ -z "$*" ]] || echo "$*"
    fi
}

gits:prefs:put() {
    local prefsfile setting value
    setting="${1:-}" ; shift || out:fail "No setting provided"
    value="${1:-}"; shift || out:fail "No value provided"
    prefsfile="$(gits:prefs:filepath)"

    [[ -f "$prefsfile" ]] || touch "$prefsfile"

    ensureline "$prefsfile" "$setting\s*=.*" "$setting = $value"
}

gits:prefs:filepath() {
    local searchdir
    searchdir="$PWD"

    while [[ ! -d "$searchdir/.git" ]]; do
        searchdir="$(dirname "$searchdir")"
        [[ "$searchdir" != / ]] || out:fail "'$PWD' is not in a git repository."
    done

    echo "$searchdir/.git-shortcuts"
}

gits:prefs:advise() {
    out:info "Set '$1 = $2' in .git-shortcuts to make this decision permanent."
}
