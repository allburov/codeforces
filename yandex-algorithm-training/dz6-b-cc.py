def read_input():
    with open('cubroot.in') as input_:
        a, b, c, d = list(map(int, input_.readline().split()))
    return a, b, c, d


PRE = 1e-5


def middleFind(left, right, check) -> int:
    while left + PRE < right:
        middle = (left + right) / 2
        if check(middle):
            right = middle
        else:
            left = middle
    return left


def task(a, b, c, d):
    def f(x):
        return a * (x * x * x) + b * (x * x) + c * (x) + d

    # find range
    r = 1
    while f(r) * f(-r) > 0:
        r *= 2

    def checkPlusX(num):
        y1 = f(num)
        return y1 > 0

    def checkMinusX(num):
        y1 = f(num)
        return y1 < 0

    r += 1
    check = checkPlusX if a > 0 else checkMinusX
    res = middleFind(left=-r, right=r, check=check)
    return res


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
