def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        nums = list(map(int, input_.readline().split()))
        assert len(nums) == n
        yield nums
        k = int(input_.readline())
        queries =  list(map(int, input_.readline().split()))
        assert len(queries) == k
        yield queries


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
    for num in next(iterator):
        n = len(nums)
        lPos = middleFind(nums, num, gte)
        if lPos in (0, n-1) or nums[lPos] != num:
            answers.append(f"0 0")
            continue

        rPos = middleFind(nums, num, gt) - 1
        answers.append(f"{lPos} {rPos}")
    print("\n".join(map(str, answers)))
