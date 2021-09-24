def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        nums = [0] * n
        for i in range(n):
            nums[i] = tuple(map(int, input_.readline().split()))
    return nums,


START = 1
END = 0



def task(points):
    nums = []
    for start, duration in points:
        nums.append((start, START))
        nums.append((start + duration, END))
    nums.sort()

    result = 0
    count = 0
    for x, type in nums:
        if type == START:
            count += 1
            result = max(result, count)
        else:
            count -= 1

    return result


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
