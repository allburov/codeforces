def binarySearchNumbers(left, right, check) -> int:
    while left < right:
        middle = (left + right) // 2
        if check(middle):
            right = middle
        else:
            left = middle + 1
    return left


def binarySearchList(nums, k, check) -> int:
    n = len(nums)
    left, right = 0, n - 1
    while left < right:
        middle = (left + right) // 2
        if check(nums[middle], k):
            right = middle
        else:
            left = middle + 1
    return left
