def read_input():
    with open('multigraph.in') as input_:
        n, m = input_.readline().split()
        n, m = int(n), int(m)
        yield n, m
        for _ in range(m):
            yield tuple(map(int, input_.readline().split()))


class Solver:
    def __init__(self, n):
        self.edges = dict()
        for i in range(1, n + 1):
            self.edges[i] = set()

    def fill(self, start, stop):
        if start == stop:
            return
        if stop in self.edges[start]:
            return

        self.edges[start].add(stop)
        self.edges[stop].add(start)

    def get_answer(self):
        answer = set()
        for start, stops in self.edges.items():
            for stop in stops:
                res = (start, stop) if start < stop else (stop, start)
                if res in answer:
                    continue
                answer.add(res)

        n = len(self.edges)
        m = len(answer)
        yield f"{n} {m}"

        for start, stop in answer:
            yield f"{start} {stop}"


if __name__ == "__main__":
    iterator = read_input()
    n, m = next(iterator)
    solver = Solver(n)

    for nums in iterator:
        answer = solver.fill(*nums)

    print("\n".join(solver.get_answer()))
