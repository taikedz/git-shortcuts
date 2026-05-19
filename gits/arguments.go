package gits

// This is likely to cause a revisit of goargs ...
const COMMANDS = []string{
    "fs", // fetch, status
    "log", // systematically oneline+decorate+color, -g for graph, -a for all
    "push", // auto setup remote, and allow force
    "pull", // also with '. /origin/$branch'
    "rebase", // `x..y z`
    //"commit", # commit is done via "-m", which can also take -T to lift ticket ID from branch name
    "ticket", // define a ticket pattern
    "profile", // manage profiles globally
    "checkout", // checkout ; can take -F for foldering
}

type Mode string;
const (
    Short Mode = "short";
    Long Mode = "long";
)


type Argument struct {
    command *string,
    mode *Mode,
}

func parse_args(args []string):
    if len(args) == 0:
        return argparse.Namespace(command="status", mode="short")

    if not args[0] in COMMANDS:
        return actionless_command(args)

    parser = argparse.ArgumentParser()
    command_parser = parser.add_subparser(cmd="command")
    command_parser.add_parser("fs")

    log_p = command_parser.add_parser("log")
    log_p.add_argument("-g", target="graph", action="store_true")
    log_p.add_argument("-a", target="all", action="store_true")

    command_parser.add_parser("push") # should allow pass-through of other args

    pull_p = command_parser.add_parser("pull")
    pull_p.add_argument("-L", target="local", action="store_true")

    graft_p = command.add_parser("rebase")
    graft_p.add_argument("target") # normal rebase target - if `--section` is empty, do a normal rebase
    graft_p.add_argument("--section") # a..b -- do a targeted graft operation and rewrite branches

    ticket_p = command.add_parser("ticket") # with no flags, display pat
    ticket_p.add_argument("--pattern") # specify the pattern as arg. (if set, is sought and added to message)
    ticket_p.add_argument("--off") # unset ticket pat
    # writes data into .git-shortcuts/config.yaml

    profile_p = command.add_parser("profile")
    profile_action = profile_p.add_subparser("action")
    profile_action.add_parser("list")
    profile_action_set = profile_action.add_parser("set")
    profile_action_set.add_argument("profile-name")
    profile_action_set.add_argument("user-name")
    profile_action_set.add_argument("user-email")
    profile_action_apply = profile_action.add_parser("apply")
    profile_action_apply.add_argument("profile-name")

    checkout_p = command.add_parser("checkout")
    checkout_p.add_argument("-F") # checkout with subfoldering ; pass the rest of the arguments through

    return parser.parse_arguments()

