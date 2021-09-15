def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        string = input_.readline().strip("\n")
        assert len(string) == n
    return (string,)


def task(string):
    from collections import Counter
    symbols = list(sorted(set(string)))
    counter = Counter(string)
    result = []
    middle = ""
    for sym in symbols:
        result.append(sym * (counter[sym] // 2))
        if counter[sym] % 2 == 1 and not middle:
            middle = sym

    return "".join(result) + middle + "".join(result[::-1])


assert task("QAZQAZ") == "AQZZQA"
assert task("QAZQAZAC") == "AQZAZQA"

if __name__ == "__main__":
    args = read_input()
    res = task(*args)
    print(res)
