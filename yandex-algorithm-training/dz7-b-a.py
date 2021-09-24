def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        nums = [0] * n
        for i in range(n):
            nums[i] = tuple(map(int, input_.readline().split()))
    return nums,


START = 0
END = 1


def task(points):
    nums = []
    for start, stop in points:
        nums.append((start, START))
        nums.append((stop, END))
    nums.sort()

    result = 0
    count = 0
    color_start = None
    for x, type in nums:
        if type == START:
            if not color_start:
                color_start = x
            count += 1
            continue
        else:
            count -= 1
            if count == 0:
                result += x - color_start
                color_start = None

    return result


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
