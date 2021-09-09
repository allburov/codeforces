def read_input():
    with open('input.txt') as input_:
        nums = list(map(int, input_.readline().split()))
    return (nums,)


def task(nums):
    meet = set()
    for n in nums:
        if n in meet:
            yield "YES"
        else:
            yield "NO"
            meet.add(n)

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print("\n".join(answer))
