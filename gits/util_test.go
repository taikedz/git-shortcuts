package gits

import (
	"github.com/taikedz/gocheck"
	"testing"
)

func TestSplitStringMultichar(t *testing.T) {
	res := SplitStringMultichar("12.04,1:5,1", ".,:")
	exp := []string{"12", "04", "1", "5", "1"}
	gocheck.EqualArr(t, exp, res)
}

func TestExtractInts(t *testing.T) {
	res, err := ExtractInts("12.04,1:5,1")
	if err != nil {
		t.Errorf("Error extracting ints: %s\n", err)
		return
	}
	exp := []int{12, 4, 1, 5, 1}
	gocheck.EqualArr(t, exp, res)
}
