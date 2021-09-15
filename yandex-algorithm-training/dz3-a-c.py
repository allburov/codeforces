def read_input():
    with open('input.txt') as input_:
        n, k = input_.readline().split()
        n, k = int(n), int(k)
        yield n, k
        for _ in range(k):
            yield tuple(map(int, input_.readline().split()))


WEEKENDS = (0, 6)


class Solver:
    def __init__(self, n, k):
        from collections import defaultdict
        self.n = n
        self.k = k
        self.counter = 0
        self.parties = defaultdict(set)
        self.days= set()

    def fill(self, a, b):
        self.parties[b].add(a)

    def get_answer(self):
        for day in range(1, self.n+ 1):
            if day % 7 in WEEKENDS:
                continue

            if self.has_it(day):
                self.counter += 1
                continue
        return self.counter

    def has_it(self, day):
        for b, aas in self.parties.items():
            for a in aas:
                if a>day:
                    continue
                if (day - a) % b == 0:
                    return True
        return False


if __name__ == "__main__":
    iterator = read_input()

    n, k = next(iterator)
    solver = Solver(n, k)

    for nums in iterator:
        answer = solver.fill(*nums)

    print(solver.get_answer())
