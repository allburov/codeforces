def read_input():
    with open('input.txt') as input_:
        n, q = map(int, input_.readline().split())
        nums = list(map(int, input_.readline().split()))
        yield nums
        for _ in range(q):
            start, end = map(int, input_.readline().split())
            yield start, end


class Solver:
    def __init__(self, nums):
        n = len(nums)
        self.prefix = [0] * (n+1)
        for i, num in enumerate(nums, start=1):
            self.prefix[i] +=self.prefix[i-1] + num

    def get(self, start, end):
        return self.prefix[end] - self.prefix[start-1]


if __name__ == "__main__":
    iterator = read_input()
    nums = next(iterator)
    solver = Solver(nums)
    for start, end in iterator:
        res = solver.get(start, end)
        print(res)
