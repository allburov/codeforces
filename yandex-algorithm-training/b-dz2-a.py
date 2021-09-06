def read_input():
    nums = []
    with open('input.txt') as input_:
        while True:
            num = int(input_.readline())
            if num == 0:
                return nums
            nums.append(num)


def task(nums):
    max_ = max(nums)
    counter = {}
    for num in nums:
        if num in counter:
            counter[num] += 1
        else:
            counter[num] = 1

    return counter[max_]


# assert task(5, 1, 1) == 0

if __name__ == "__main__":
    args = read_input()
    answer = task(args)
    print(answer)
