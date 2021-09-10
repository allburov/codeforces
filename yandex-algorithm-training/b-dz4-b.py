def read_input():
    with open('input.txt') as input_:
        lines = input_.readlines()
        nums = []
        for line in lines:
            candidate, num = line.split()
            num = int(num)
            nums.append((candidate, num))
    return(nums,)


def task(nums):
    from collections import defaultdict
    sums = defaultdict(int)
    for candidate, num in nums:
        sums[candidate] += num

    return list(f'{color} {num}' for color, num in sorted(sums.items()))


if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print("\n".join(answer))
