import bisect
from collections import Counter


def read_input():
    with open('input.txt') as input_:
        n, m = tuple(map(int, input_.readline().split()))
        nums = list(map(int, input_.readline().split()))
    return n, m, nums


def task(n, m, nums):
    pass


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
