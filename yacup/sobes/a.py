def read_input():
    with open('input.txt') as input_:
        string1 = input_.readline().strip("\n")
        string2 = input_.readline().strip("\n")
    return string1, string2


def task(string1, string2):
    set1 = set(string1)
    return sum(1 for num in string2 if num in set1)


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
