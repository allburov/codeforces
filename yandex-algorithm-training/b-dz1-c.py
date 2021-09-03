def read_input():
    with open('input.txt') as input_:
        f, s, year = input_.readline().split(' ')
    return map(int, [f, s, year])


def task(x, y, year):
    if 1 <= x <= 12 and 1 <= y <= 12:
        if x == y:
            return 1
        return 0
    return 1
    # valid_eur = 1 <= x <= 31 and 1 <= y <= 12
    # valid_us = 1 <= y <= 31 and 1 <= x <= 12
    # if valid_us and valid_eur:
    #     return 0
    # if not valid_us and not valid_eur:
    #     raise RuntimeError()
    # return 1


assert task(1, 2, 2003) == 0
assert task(2, 29, 2008) == 1

if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print(answer)
