HOUSE = 1
STORE = 2


def read_input():
    with open('input.txt') as input_:
        nums = list(map(int, input_.readline().split()))
    return nums


MAX = 100


def task(nums):
    n = len(nums)
    toLeft = [MAX] * (n)
    toRight = [MAX] * (n)
    distance = [0] * (n)

    # to left
    for i in range(n):
        num = nums[i]
        if num == STORE:
            toLeft[i] = 0
        else:
            toLeft[i] = toLeft[i - 1] + 1 if i - 1 >= 0 else MAX

    # to right
    for i in range(n - 1, -1, -1):
        num = nums[i]
        if num == STORE:
            toRight[i] = 0
        else:
            toRight[i] = toRight[i + 1] + 1 if i + 1 <= n - 1 else MAX

    for i, num in enumerate(nums):
        if num == HOUSE:
            distance[i] = min(toLeft[i], toRight[i])

    return max(distance)


if __name__ == "__main__":
    args = read_input()
    answer = task(args)
    print(answer)
