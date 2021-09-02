def read_input():
    with open('input.txt') as input_:
        N, i, j = input_.readline().split(' ')
    return map(int, [N, i, j])


def task(N, i, j):
    if j < i:
        i, j = j, i

    between = j - i - 1
    across = N - j + i - 1
    return min(between, across)


assert task(100, 5, 6) == 0
assert task(10, 1, 9) == 1

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(answer)
