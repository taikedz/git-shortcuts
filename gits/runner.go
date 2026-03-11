package gits

/*
* Execute a command, and get its return code and output
*
* CmdRun() : runs a command and dumps its output. Result object will always have empty Stdout data.
* CmdCapture() : runs a command and captures its output. Result object contains any Stdout data the subprocesses printed.
*
* Cmd*() functions always return a Result object. This can either be inspected, or can cause an exit action by calling .OnFail()
*
*   CmdRun(0, "ls", "/var/log/secure").OrFail("Could not open secure logs")
*
* To inspect the error, use
*
*   if res := CmdRun(NEED_ROOT, "ls", "/var/log/secure"); res.err != nil {
*       // do error checking here on res.err object
*   }
* */

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

const NEED_ROOT int = 1

type Result struct {
	code   int
	Stdout string
	err    error
}

// Fail if status is not zero, or re-return Result object itself
func (r Result) OrFail(msg string) Result {
	if r.code < 0 {
		Fail(99, msg, r.err)
	} else if r.code > 0 {
		Fail(r.code, "Error", r.err)
	}
	return r
}

func (r Result) GetError() error {
	return r.err
}

func (r Result) Ok() bool {
	return r.code == 0
}

func CmdRun(flags int, tokens ...string) Result {
	return runCapturing(true, flags, tokens...)
}

func CmdCapture(flags int, tokens ...string) Result {
    return runCapturing(false, flags, tokens...)
}

func runCapturing(dump bool, flags int, tokens ...string) Result {
	if len(tokens) < 1 {
        return Result{-1, "", fmt.Errorf("command not supplied")}
	}

    t_cmd := tokens[0]
    t_args := tokens[1:]

	if (flags&NEED_ROOT == NEED_ROOT) && !IsRootUser() {
        return Result{10, "", fmt.Errorf("root required")}
	}

	cmd := exec.Command(t_cmd, t_args...)
    printVerbose("%s %s\n", t_cmd, strings.Join(t_args, " "))

    if dump {
        cmd.Stdout = os.Stdout
        cmd.Stderr = os.Stderr
        cmd.Stdin = os.Stdin
    }
    if err := cmd.Start(); err != nil {
        return Result{-1, "", fmt.Errorf("execution error: %v", err)}
    }

    // Getting the error code requies a bit of boilerplate
    // https://stackoverflow.com/a/10385867/2703818
    if err := cmd.Wait(); err != nil {
        if exiterr, ok := err.(*exec.ExitError); ok {
            return Result{exiterr.ExitCode(), "", exiterr}
        } else {
            return Result{-1, "", err}
        }
    }
    return Result{0, "", nil}
}

