def read_input():
    with open('input.txt') as input_:
        N = int(input_.readline())
        yield set(range(1, N + 1))

        line = input_.readline()
        while line.strip("\n") != "HELP":
            nums = set(map(int, line.split()))
            yield nums
            line = input_.readline()


class Solver:
    def __init__(self):
        self.nums = None

    def answer_for(self, nums):
        if self.nums is None:
            self.nums = nums
            return

        nums_in = sum(1 for num in nums if num in self.nums)
        nums_yes = nums_in
        nums_no = len(self.nums) - nums_in

        if nums_no >= nums_yes:
            self.nums -= nums
            return "NO"
        else:
            self.nums &= nums
            return "YES"

    def get_answer(self):
        return sorted(self.nums)


if __name__ == "__main__":
    solver = Solver()
    for nums in read_input():
        answer = solver.answer_for(nums)
        if answer:
            print(answer)

    print(" ".join(map(str, solver.get_answer())))
