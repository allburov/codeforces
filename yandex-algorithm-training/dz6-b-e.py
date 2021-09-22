import bisect
from collections import Counter


def read_input():
    with open('input.txt') as input_:
        n, k = list(map(int, input_.readline().split()))
        nums = list(map(int, input_.readline().split()))
    return n, k, nums


def binarySearch(left, right, check) -> int:
    while left < right:
        middle = (left + right) // 2
        if check(middle):
            right = middle
        else:
            left = middle + 1
    return left


def coverAll(k, l, nums) -> bool:
    n = len(nums)
    start = 0
    left = k

    while left > 0 and start <= n - 1:
        start = bisect.bisect_right(nums, nums[start] + l, lo=start)
        left -= 1
    return start > n - 1


assert coverAll(k=2, l=1, nums=[1, 2, 3, 7, 8, 9]) is False
assert coverAll(k=2, l=2, nums=[1, 2, 3, 7, 8, 9]) is True
assert coverAll(k=3, l=2, nums=[1, 2, 3, 7, 8, 9]) is True
assert coverAll(k=2, l=3, nums=[1, 2, 3, 7, 8, 9]) is True


def task(n, k, nums):
    nums.sort()
    counter = Counter(nums)
    maxLen = 2*10**9 + 2

    def check(l):
        return coverAll(k, l, nums)

    res = binarySearch(0, maxLen, check=check)
    return res


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
