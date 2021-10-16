
def read_input():
    with open("input.txt") as input_:
        n, m = tuple(map(int, input_.readline().split()))
        yield n, m
        for i in range(n):
            yield json.loads(input_.readline())


class Solver:
    def __init__(self, m):
        self.m = m
        self.theFeed = []

    def fill(self, feed):
        for position in feed["offers"]:
            if len(self.theFeed) == self.m:
                return
            self.theFeed.append(position)

    def get(self):
        return dict(offers=self.theFeed)


def main():
    iterator = read_input()
    n, m = next(iterator)
    solver = Solver(m)
    for feed in iterator:
        solver.fill(feed)

    res = solver.get()
    print(json.dumps(res))


if __name__ == "__main__":
    main()
