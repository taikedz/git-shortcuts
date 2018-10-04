### gits gc Usage:help-gc
#
# Remove all git commits and data that cannot be reached anymore.
#
###/doc

gits:gc-full() {
    gits:local-help gc "$@"

    gits:run -c gc.reflogExpire=0 \
        -c gc.reflogExpireUnreachable=0 \
        -c gc.rerereresolved=0 \
        -c gc.rerereunresolved=0 \
        -c gc.pruneExpire=now \
        gc
}
