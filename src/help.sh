
### Git Shortcuts Usage:help
#
# Tool to provide shortcut commands to common onerous git operations.
#
# The tool displays the command, and executes them. To not execute the command, set `GITS_no_execute=true` in your environment
#
# Some commands (log, diff) can optionally use `less` as a pager.
# Set `GITS_use_less_ms` environment variable to a float indicating the amount of time to sleep before activating the pager.
# Recommended values `0` (just activate pager) or `0.2` (prevent command display from bleeding into the pager session)
#
# Available commands all have their own --help section
#
# gits
#   Display short status
#
# gits native [COMAND ARGUMENTS ...]
#   Pass the command and arguments to the native git installation
#   Useful when 'git' is aliased to 'gits' (alias git=gits) and you
#   want the standard git behaviour.
#
# gits fs
#   Fetch metadata, and display detailed status
#
# gits log [OPTIONS]
#   Display log, defaulting to oneline display
# 
# gits [diff] [RANGE] FILES ...
#   See file diffs
#
# gits FILES ... -m[m] [MESSAGE ...]
#   Commit/amend
#
# gits push [REMOTE [BRANCH]]
#   Push to BRANCH on REMOTE. If REMOTE or BRANCH are not declared, they will be inferred
#
# gits pull [backtrack [N]]
#   Pull changes, unless branch has diverged from upstream.
#   Optionally rollback before pulling
#
# gits gc
#   Garbage collect resources on unreachable commit paths
#
# gits profile [...]
#   Manage user.* config profiles
#
# gits version [ ls|bump [KEYWORD] ]
#   See the latest tagged version, suggest next version
#
###/doc

