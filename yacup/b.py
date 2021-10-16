import json
from collections import deque

CATEGORY = 0
OFFER = 1

PRINT = 0
MERGE = 1


def read_input():
    with open("input.txt") as input_:
        n = int(input_.readline())
        for i in range(n):
            line = input_.readline().strip("\n")
            if line == "PRINT":
                yield PRINT, (0, 0)
            else:
                line = input_.readline().strip("\n")
                attributes = set(list(line.split())[1:])
                k = int(input_.readline())

                lines = []
                for _ in range(k):
                    line = input_.readline().strip("\n")
                    lines.append(line)
                data = json.loads("".join(lines))

                yield MERGE, (attributes, data)


class Solver:
    def __init__(self):
        self.data = {}

    def merge(self, attributes, data):
        q = deque()
        q.append((data, self.data))
        while q:
            data, parent = q.pop()
            for key, value in data.items():
                if key not in parent or key in attributes:
                    parent[key] = value
                elif not value:
                    continue
                else:
                    q.append((value, parent[key]))

    def result(self, data, a):
        print = a.append
        print("{")
        keys = sorted(data.keys())
        n = len(keys)
        for i, key in enumerate(keys):
            print(f'"{key}":')
            self.result(data[key], a)
            if i != n - 1:
                print(",")
        print("}")
        return a


def main():
    iterator = read_input()
    solver = Solver()
    for type, data in iterator:
        if type == MERGE:
            solver.merge(*data)
        else:
            res = solver.result(solver.data, deque())
            print("".join(res))


if __name__ == "__main__":
    main()
