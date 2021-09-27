import math
import sys


def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        yield n
        for _ in range(n):
            yield tuple(map(float, input_.readline().split()))


END = 0
START = 1
MAX_PI = 2 * math.pi

NONE = (-1,-1)

class Solver:
    def __init__(self, n):
        self.r1 = -sys.maxsize
        self.r2 = sys.maxsize
        self.points = [NONE] * (n * 4)
        self.n = 0
        self.i = 0

    def fill(self, r1, r2, ph1, ph2):
        i = self.i
        self.n += 1
        self.r1 = max(r1, self.r1)
        self.r2 = min(r2, self.r2)
        if ph1 < ph2:
            self.points[i] = (ph1, START)
            i += 1
            self.points[i] = (ph2, END)
            i += 1
        else:
            self.points[i] = (0, START)
            i += 1
            self.points[i] = (ph2, END)
            i += 1
            self.points[i] = (ph1, START)
            i += 1
            self.points[i] = (MAX_PI, END)
            i += 1
        self.i = i

    def solve(self):
        r = self.r2 - self.r1
        if r <= 0:
            return 0
        r_diff_square = self.r2 ** 2 - self.r1 ** 2

        area = 0
        self.points.sort()
        count = 0
        last_start = 0
        for point, type in self.points:
            if point == -1 and type == -1:
                continue
            if type == START:
                count += 1
                if count == self.n:
                    last_start = point
            else:
                if count == self.n:
                    a = point - last_start
                    S = (a / 2) * r_diff_square
                    area += S

                count -= 1
        return area


def main():
    iterator = read_input()
    n = next(iterator)
    solver = Solver(n)
    for nums in iterator:
        solver.fill(*nums)
    res = solver.solve()
    print(res)


if __name__ == "__main__":
    main()
