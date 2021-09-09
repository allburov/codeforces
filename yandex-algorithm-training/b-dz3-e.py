def read_input():
    with open('input.txt') as input_:
        M = int(input_.readline())
        witnesses = []
        for _ in range(M):
            witnesses.append(set(input_.readline().strip("\n")))

        N = int(input_.readline())
        nums = []
        for _ in range(N):
            nums.append(input_.readline().strip("\n"))

    return witnesses, nums


def task(witnesses, nums):
    matches = [0] * len(nums)

    for i, num in enumerate(nums):
        num_set = set(num)
        for witness in witnesses:
            if len(witness - num_set) == 0:
                matches[i] += 1

    if not matches:
        return

    max_matches = max(matches)
    for i, num in enumerate(nums):
        if matches[i] == max_matches:
            yield num


if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print("\n".join(answer))
