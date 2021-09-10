from fractions import Fraction


def read_input():
    with open('input.txt') as input_:
        lines = input_.readlines()
        nums = []
        for line in lines:
            *candidate, num = line.split()
            num = int(num)
            candidate = " ".join(candidate)
            nums.append((candidate, num))
    return (nums,)


PLACES = 450


def task(nums):
    from collections import defaultdict
    sums = defaultdict(int)
    n = len(nums)
    quotient = Fraction(sum((num for _, num in nums)), PLACES)

    left = PLACES
    for party, num in nums:
        result = Fraction(num) / quotient
        sums[party] = int(result)
        left -= int(result)

    def sort_by(x):
        party, num = x
        s = num % quotient
        return s

    for party, result in sorted(nums, key=sort_by, reverse=True):
        if left == 0:
            break
        sums[party] += 1
        left -= 1

    return [f"{name} {sums[name]}" for name, _ in nums]


if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print("\n".join(answer))
