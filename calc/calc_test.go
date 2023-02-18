package calc_test

import (
	"testing"

	"github.com/kskitek/coverdiff/calc"
)

func TestCalc(t *testing.T) {
	cases := []struct {
		a        int
		b        int
		op       calc.Op
		expected int
	}{
		{1, 2, calc.Add, 3},
		{3, 2, calc.Sub, 1},
	}

	for _, tc := range cases {
		t.Run(tc.op.String(), func(t *testing.T) {
			result := calc.Calc(tc.a, tc.b, tc.op)
			if result != tc.expected {
				t.Errorf("expected %d got %d", tc.expected, result)
			}
		})
	}
}
