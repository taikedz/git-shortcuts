# Git Shortcuts

A utility to help with long-winded git commands.

A clean-slate implementation after re-thinking what [`git-newbie`](https://github.com/taikedz/git-newbie) was trying to do.

Git has quite a few long-winded commands that are frequently useful, and some common activities can be sped-up a little.

This tool can either be used to run commands using shorthands, or just to provide reminders, letting you type them yourself (learn by doing!)

## Features

`gits` provides short-hand commands for common long-winded or hard-to-remember git commands. It prints the commands it runs, and then executes them. If you want to use it just to show the commands as reminders, set `GITS_no_execute=true` in your environment or `~/.bashrc` file

Find out your current status

    $ gits
    /home/tai/git/github/taikedz/git-shortcuts
    git status -sb -uall 
    ## master...origin/master [ahead 1]

    (see also: gits fs)

Do a fetch/status check

    $ gits fs

See diffs, always in colour (set `GIT_use_less=0` in your environment to view in `less` pager)

    $ gits file1 file2 file3

Commit the same files

    $ gits file1 file2 file3 -m my commit message

... and get warnings if you commit on master ...

	$ gits . -m
    You are comitting on master - continue ? [y/N] > n
    Set 'allow_master_commits = false' in .git-shortcuts to make this decision permanent.
    ERROR FAIL: Abort

See the log in color, with decorations (if your system's default config doesn't do this automatically), in oneline mode

    $ gits log
    git log --color --decorate=short --oneline 
    8d7c337 (HEAD -> master) Make use of 'less' configurable, rework help
    4dd3e2b (origin/master) Pull message is OK when repo is OK
    86607ba Add status check for specified directories
    16c9052 fix pull verification issue
    1a94b82 Add pull check, change log command options


See the full log graph, in colour, with decorations, in oneline mode

    $ gits log -g

    # versus `git log --graph --oneline --all --decorate=short --color`

Save and apply different profiles

    # One-time setup
    $ gits profile save coder "Coder Name" "coder@site.net"

    $ gits profile apply coder

    $ gits profile
    Current config:
      Name:  Tai Kedzierski
      Email: dch.tai@gmail.com

Commit with an alternate profile

    $ gits . -m/user2

    # sets user2's details in `config user.name` and `config user.email`,
    #  commits
    #  then reverts


( and more to come ... )

# Contributing

This tool is written using [Bash Builder](https://github.com/taikedz/bash-builder). You are welcome to contribute changes and additional features you think would be helpful.

The specific goals of Git Shortcuts is to provide a tool that provides short-hand ways of performing long-winded tasks or inconveniently lengthy commands.
