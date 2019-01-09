#%include std/args.sh

### gits gc [-F|--no-fetch] [-P|--no-prune] Usage:help-gc
#
# Eager garbage cleaning function.
#
# * Fetches remote metadata (unless --no-fetch/-F specified)
# * Prunes cached remote branches no longer on remote (unless --no-pruner/-P specified)
# * Removes all commits and data that cannot be reached anymore
#
###/doc

gits:gc-full() {
    local remote

    gits:local-help gc "$@"

    if ! args:has "--no-fetch" "$@" && ! args:has "-F" "$@"; then
        gits:run fetch
    fi

    if ! args:has "--no-prune" "$@" && ! args:has "-P" "$@"; then
        git remote | while read remote; do
            gits:run remote prune "$remote"
        done
    fi

    gits:run -c gc.reflogExpire=0 \
        -c gc.reflogExpireUnreachable=0 \
        -c gc.rerereresolved=0 \
        -c gc.rerereunresolved=0 \
        -c gc.pruneExpire=now \
        gc
}
