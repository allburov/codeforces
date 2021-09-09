YES = "YES"
NO = "NO"
HELP = "HELP"


def read_input():
    with open('input.txt') as input_:
        N = int(input_.readline())
        yield set(range(1, N+1)), YES

        line = input_.readline()
        while line.strip("\n") != HELP:
            nums = set(map(int, line.split()))
            ans = input_.readline().strip("\n")
            yield nums, ans

            line = input_.readline()


class Solver:
    def __init__(self):
        self._set = None

    def yes(self, aset):
        if self._set is None:
            self._set = aset
            return
        self._set &= aset

    def no(self, aset):
        self._set -= aset

    def solve(self):
        return sorted(self._set)


if __name__ == "__main__":
    solver = Solver()
    for nums, ans in read_input():
        if ans == YES:
            solver.yes(nums)
        elif ans == NO:
            solver.no(nums)
        else:
            raise RuntimeError(f"Unknown ans={ans}")

    answer = solver.solve()
    print(" ".join(map(str, answer)))
