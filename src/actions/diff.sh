### diff [RANGE] ARGUMENTS ... Usage:help-diff
#
# Display diffs in colour
#
# The RANGE option can be specified as "/" optinally followed by a first number,
#   optionally followed by another "/", optionally followed by a second number
#
# The first slash specified on its own causes the comparison to be from HEAD to current state, useful for diffing files that have been staged
#
# A subsequent first number N diffs from HEAD~$N to HEAD
#
# A subsequent second slash causes diff from HEAD~$N to current state, even if staged
#
# A final second number M causes a diff from HEAD~$N to HEAD~$M
#
# Examples:
#
# See diffs for files ; will show nothing if files are staged
#
#   gits file1 file2
#
# See diffs for staged files
#
#   gits / file1 file2
#
# See diffs from HEAD~3 to HEAD
#
#   gits /3/
#
###/doc

gits:diff() {
    gits:commit:check "$@" || {
        gits:commit "$@"
        return
    }

    local arg parameters
    parameters=(:)

    arg="${1:-}"

    gits:local-help-noempty diff "$@"

    if [[ "$arg" = / ]]; then
        shift
        parameters+=(HEAD -- "$@")
    elif [[ "$arg" =~ ^/([0-9]+)$ ]]; then
        shift
        parameters+=(HEAD~"${BASH_REMATCH[1]}" -- "$@")
    elif [[ "$arg" =~ ^/([0-9]+)/$ ]]; then
        shift
        parameters+=(HEAD~"${BASH_REMATCH[1]}" HEAD -- "$@")
    elif [[ "$arg" =~ ^/([0-9]+)/([0-9]+)$ ]]; then
        shift
        parameters+=(HEAD~"${BASH_REMATCH[1]}" HEAD~"${BASH_REMATCH[2]}" -- "$@")
    else
        parameters+=("$@")
    fi

    gits:pager gits:run diff --color "${parameters[@]:1}"
}
