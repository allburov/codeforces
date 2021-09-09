def read_input():
    with open('input.txt') as input_:
        nums = list(map(int, input_.readline().split()))
    return (nums,)


def task(nums):
    from collections import Counter
    c = Counter(nums)
    for n in nums:
        if c[n] == 1:
            yield str(n)

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(" ".join(answer))
