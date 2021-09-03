def read_input():
    with open('input.txt') as input_:
        N = int(input_.readline())
        nums = list(map(int, input_.readline().split()))
        assert len(nums) == N
    return (nums,)


def task(nums):
    n = len(nums)
    return nums[n // 2]


assert task([1, 2, 3, 4]) == 3
assert task([-1, 0, 1]) == 0

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(answer)
