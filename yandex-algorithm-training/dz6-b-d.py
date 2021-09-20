def read_input():
    with open('input.txt') as input_:
        A, K, B, M, X = list(map(int, input_.readline().split()))
    return A, K, B, M, X


def middleFind(left, right, check) -> int:
    while left < right:
        middle = (left + right) // 2
        if check(middle):
            right = middle
        else:
            left = middle + 1
    return left


def howmany(tree_in_day, vacation_every, day):
    return tree_in_day * (day // vacation_every * (vacation_every - 1) + day % vacation_every)


def task(A, K, B, M, X):
    def check(num):
        done = howmany(tree_in_day=A, vacation_every=K, day=num) + \
               howmany(tree_in_day=B, vacation_every=M, day=num)
        return done >= X

    res = middleFind(left=1, right=X, check=check)
    return res


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
