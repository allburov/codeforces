def read_input():
    with open('input.txt') as input_:
        q = input_.readline()
        nums = list(map(int, input_.readline().split()))
        return nums


class Solver:
    def __init__(self, nums):
        self.nums = nums

    def get(self):
        n = len(self.nums)
        maxSum = self.nums[0]
        i, j = 0, -1
        currentSum = 0
        while j < n-1:
            j += 1
            currentSum += self.nums[j]
            maxSum = max(currentSum, maxSum)

            if currentSum < 0:
                i = j
                currentSum = 0
                continue

        return maxSum


if __name__ == "__main__":
    nums = read_input()
    solver = Solver(nums)
    res = solver.get()
    print(res)
