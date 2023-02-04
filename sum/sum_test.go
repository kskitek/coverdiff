package sum_test

import (
	"testing"

	"github.com/kskitek/coverdiff/sum"
)

func TestSum(t *testing.T) {
	result := sum.Sum(1, 2)
	expected := 3
	if result != expected {
		t.Errorf("expected %d got %d", expected, result)
	}
}
