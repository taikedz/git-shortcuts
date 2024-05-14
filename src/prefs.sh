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

    local prefsdir="$searchdir/.git-shortcuts"
    local prefsfile="$prefsdir/prefs"
    [[ -d "$prefsdir" ]] || {
        if [[ -f "$prefsdir" ]]; then
            mv "$prefsdir" "$prefsdir.prefs"
        fi

        mkdir "$prefsdir"
        echo '*' > "$prefsdir/.gitignore"

        if [[ -f "$prefsdir.prefs" ]]; then
            mv "$prefsdir.prefs" "$prefsfile"
        fi
    }

    echo "$prefsfile"
}

gits:prefs:advise() {
    out:info "Set '$1 = $2' in .git-shortcuts/prefs to make this decision permanent."
}
