def read_input():
    with open('input.txt') as input_:
        a = int(input_.readline())
        b = int(input_.readline())
        c = int(input_.readline())
        d = int(input_.readline())
    return (a, b, c, d)


def task(a, b, c, d):
    if a == 0 and b == 0:
        return "INF"

    x = -(b / a)
    if int(x) != x:
        return "NO"

    if (c * x + d) == 0:
        return "NO"

    return int(x)


assert task(3, 0, 2, 2) == 0
assert task(0, 0, 2, 2) == "INF"
assert task(1, 1, 2, 2) == "NO"
assert task(2, -4, 7, 1) == 2
assert task(35, 14, 11, -3) == "NO"

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(answer)
