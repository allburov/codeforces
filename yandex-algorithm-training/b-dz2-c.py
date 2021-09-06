def read_input():
    with open('input.txt') as input_:
        string = input_.read().splitlines()[0]
    return string


def task(string):
    n = len(string)
    i, j = 0, n - 1
    distance = 0
    while i < j:
        distance += int(string[i] != string[j])
        i+=1
        j-=1

    return distance

assert task("a") == 0
assert task("ab") == 1
assert task("cognitive") == 4
assert task("test") == 1

if __name__ == "__main__":
    args = read_input()
    answer = task(args)
    print(answer)
