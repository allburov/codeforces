def read_input():
    with open('input.txt') as input_:
        input_.readline()
        lines = list(map(lambda x: x.strip("\n"), input_.readlines()))
    return lines,


def task(lines):
    startedAt = None
    lines.append("0")
    max1 = 0
    for i, num in enumerate(lines):
        if num == "1":
            if startedAt is None:
                startedAt = i
        else:
            if startedAt is None:
                continue
            count = i - startedAt
            max1 = max(max1, count)
            startedAt = None
    return max1


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
