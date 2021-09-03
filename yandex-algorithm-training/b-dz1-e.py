def read_input():
    with open('input.txt') as input_:
        d = int(input_.readline())
        x, y = map(int,input_.readline().split(" "))
    return (d, x, y)


def task(d, x, y):
    inside = x >= 0 and y >= 0 and 0 <= x + y <= d
    if inside:
        return 0
    to_a = x ** 2 + y ** 2
    to_b = y ** 2 + abs(x - d) ** 2
    to_c = x ** 2 + abs(y - d) ** 2
    min_ = min(to_a, to_b, to_c)
    if min_ == to_a: return 1
    if min_ == to_b: return 2
    if min_ == to_c: return 3


assert task(5, 1, 1) == 0
assert task(4, 2, 2) == 0
assert task(3, -1, -1) == 1
assert task(4, 4, 4) == 2

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(answer)
