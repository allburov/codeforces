def read_input():
    with open("input.txt") as input_:
        n = int(input_.readline())
        for i in range(n):
            yield input_.readline().strip("\n")
    yield "END"


class Solver:
    def __init__(self):
        self.last = None

    def fill(self, number):
        if self.last == number:
            return

        if self.last != number:
            last = self.last
            self.last = number
            return last


def main():
    iterator = read_input()
    solver = Solver()

    for num in iterator:
        res = solver.fill(num)
        if res:
            print(res)


if __name__ == "__main__":
    main()
