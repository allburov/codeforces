def read_input():
    with open("input.txt") as input_:
        n = int(input_.readline())
        for i in range(n - 1):
            yield input_.readline().strip("\n").split()

        yield None
        line = input_.readline().strip("\n")
        while line:
            yield line.split()
            line = input_.readline().strip("\n")


class Solver:
    def __init__(self):
        self.people = {}
        self.root = None
        self.roots = set()
        self.childs = set()

    def fill(self, child, parent):
        self.people[child] = parent

    def get(self, first, second):
        first_path = self.get_path(first)
        second_path = self.get_path(second)
        n = min(len(first_path), len(second_path))
        for i in range(1, n):
            if first_path[i] != second_path[i]:
                return first_path[i - 1]
        return first_path[n-1]

    def get_path(self, child):
        path = []
        while child:
            path.append(child)
            child = self.people.get(child, None)
        path.reverse()
        return path


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

    print("\n".join(answer))


if __name__ == "__main__":
    main()
