def read_input():
    with open('input.txt') as input_:
        L, K = list(map(int, input_.readline().split()))
        nums = list(map(int, input_.readline().split()))
        assert K == len(nums)
    return L, K, nums


def task(L, K, nums):
    n = K
    i, j = 0, n - 1
    center = (L - 1) / 2

    while i+1<=n-1 and nums[i + 1] <= center:
        i += 1
    while j-1 >=0 and nums[j - 1] >= center:
        j -= 1

    if i == j:
        return str(nums[i])

    return f"{nums[i]} {nums[j]}"


assert task(5, 2, [0, 2]) == "2"
assert task(14, 6, [1, 6, 8, 11, 12, 13]) == "6 8"
assert task(13, 4, [1,4,8,11]) == "4 8"

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(answer)
