def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        nums = list(map(int, input_.readline().split()))
        assert len(nums) == n
        yield nums
        k = int(input_.readline())
        for _ in range(k):
            yield list(map(int, input_.readline().split()))


def middleFind(nums, k, check) -> int:
    n = len(nums)
    left, right = 0, n - 1
    while left < right:
        middle = (left + right) // 2
        if check(nums[middle], k):
            right = middle
        else:
            left = middle + 1
    return left


def gte(m, k):
    return m >= k


def gt(m, k):
    return m > k



if __name__ == "__main__":
    iterator = read_input()
    nums = next(iterator)
    nums.append(float('-inf'))
    nums.append(float('+inf'))
    nums.sort()
    answers = []
    for l, r in iterator:
        lPos = middleFind(nums, l, gte)
        rPos = middleFind(nums, r, gt)
        answers.append(rPos - lPos)
    print(" ".join(map(str, answers)))
