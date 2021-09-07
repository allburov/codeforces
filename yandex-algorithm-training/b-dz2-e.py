def read_input():
    with open('input.txt') as input_:
        N = int( input_.readline())
        nums = list(map(int, input_.readline().split()))
        assert N == len(nums)
    return N, nums


def task(N, nums):
    return sum(nums) - max(nums)


assert task(2, [2, 1]) == 1
assert task(2, [1, 1, 2]) == 2

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(answer)
