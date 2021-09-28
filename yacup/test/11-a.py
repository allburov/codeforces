import string


def read_input():
    with open('../input.txt') as input_:
        string1 = input_.readline().strip("\n")
    return string1,


NOSHIFT = 1
SHIFT = 2
SWITCH = 3


def task(pattern):
    n = len(pattern)
    dp_down = [0] * (n + 1)
    dp_up = [0] * (n + 1)
    dp_up[0] = 2
    ascii_lowercase = set(string.ascii_lowercase)
    ascii_uppercase = set(string.ascii_uppercase)

    for i, letter in enumerate(pattern, start=1):
        if letter in ascii_lowercase:
            dp_down[i] = dp_down[i - 1] + NOSHIFT
            dp_up[i] = min(dp_up[i - 1] + SHIFT, dp_down[i - 1] + SWITCH)
        elif letter in ascii_uppercase:
            dp_down[i] = min(dp_down[i - 1] + SHIFT, dp_up[i - 1] + SWITCH)
            dp_up[i] = dp_up[i - 1] + NOSHIFT
        else:
            dp_up[i] = dp_up[i - 1] + 1
            dp_down[i] = dp_down[i - 1] + 1

    return min(dp_down[n], dp_up[n])


def main():
    args = read_input()
    res = task(*args)
    print(res)


assert task("Hello World") == 13
assert task("APPLE II") == 10

if __name__ == "__main__":
    main()
