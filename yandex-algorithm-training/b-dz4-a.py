def read_input():
    with open('input.txt') as input_:
        N = int(input_.readline())
        nums = []
        for _ in range(N):
            nums.append(tuple(map(int, input_.readline().split())))
    return N, nums


def task(N, nums):
    from collections import defaultdict
    sums = defaultdict(int)
    for color, num in nums:
        sums[color] += num

    return list(f'{color} {num}' for color, num in sorted(sums.items()))


if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print("\n".join(answer))
