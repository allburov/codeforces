def read_input():
    with open('../input.txt') as input_:
        string1 = input_.readline().strip("\n")
        string2 = input_.readline().strip("\n")
    return string1, string2


def convert(string):
    result = 0
    n = len(string)
    stepen = 0
    i = n
    while i > 0:
        if string[i - 3:i] == "one":
            result += 2 ** stepen
            i -= 3
            stepen += 1
            continue
        i -= 4
        stepen += 1
    return result


def task(string1, string2):
    number1 = convert(string1)
    number2 = convert(string2)
    if number1 == number2:
        return "="
    return ">" if number1 > number2 else "<"


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
