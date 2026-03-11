package gits

import (
	"fmt"
	"os"
	"os/user"
	"runtime"
	"strconv"
	"strings"
)

func ArrayHas(term string, stuff []string) bool {
	for _, thing := range stuff {
		if term == thing {
			return true
		}
	}
	return false
}

func IsRootUser() bool {
	u, e := user.Current()
	FailIf(e, 98, "Fatal - Could not get current user!")
	return u.Uid == "0" // posix only!
}

func IsWinAdmin() (bool, error) {
	/* This is apparently the way to handle Windows.
	*/

	// https://stackoverflow.com/a/19847868/2703818
	if runtime.GOOS != "windows" {
		return false, fmt.Errorf("not on Windows")
	}

	// https://stackoverflow.com/a/59147866/2703818
	_, err := os.Open("\\\\.\\PHYSICALDRIVE0")
	if err != nil {
		return false, nil
	}
	return true, nil
}

func ExtractInts(data string) ([]int, error) {
	tokens := SplitStringMultichar(data, ".,: ")
	var nums []int
	for _, t := range tokens {
		n, e := strconv.Atoi(strings.Trim(t, " "))
		if e != nil {
			return nil, e
		}
		nums = append(nums, n)
	}

	return nums, nil
}

func SplitStringMultichar(data string, chars string) []string {
	tokens := []string{data}

	for _, c := range chars {
		tokens = SplitStringsChar(tokens, string(c))
	}
	return tokens
}

func SplitStringsChar(data []string, char string) []string {
	var tokens []string
	for _, piece := range data {
		tokens = append(tokens, strings.Split(piece, string(char))...)
	}
	return tokens
}

