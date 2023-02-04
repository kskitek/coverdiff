package calc

type Op int

const (
	Unknown Op = iota
	Add
	Sub
	Mul
)

func (o Op) String() string {
	switch o {
	case Add:
		return "add"
	case Sub:
		return "sub"
	case Mul:
		return "mul"
	default:
		return "unknown"
	}
}

func Calc(a, b int, op Op) int {
	switch op {
	case Add:
		return a + b
	case Sub:
		return a - b
	default:
		return 0 // this is wrong, don't ever do that
	}
}
