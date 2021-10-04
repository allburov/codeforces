from collections import defaultdict


def read_input():
    with open("input.txt") as input_:
        n = int(input_.readline())
        for i in range(n-1):
            yield input_.readline().strip("\n").split()

        yield None
        line = input_.readline().strip("\n")
        while line:
            yield line.split()
            line = input_.readline().strip("\n")

FIRST_IS_CHILD = 1
SECOND_IS_CHILD = 2
NO_ONE = 0

class Solver:
    def __init__(self):
        self.people = defaultdict(set)

    def fill(self, child, parent):
        self.people[parent].add(child)

    def get(self, first, second):
        if self.dfs(root=first, find=second):
            return FIRST_IS_CHILD
        elif self.dfs(root=second, find=first):
            return SECOND_IS_CHILD
        return NO_ONE

    def dfs(self, root, find):
        for child in self.people[root]:
            if child == find:
                return True
            if self.dfs(child, find):
                return True
        return False


def main():
    iterator = read_input()
    solver = Solver()
    pair = next(iterator)
    while pair is not None:
        solver.fill(pair[0], pair[1])
        pair = next(iterator)

    answer = []
    for first, second in iterator:
        res = solver.get(first, second)
        answer.append(str(res))

    print(" ".join(answer))


if __name__ == "__main__":
    main()
