def read_input():
    with open('input.txt') as input_:
        return input_.readline().split()


OPEN = "("
CLOSE = ")"


def task(string):
    open = 0
    for s in string:
        if s == OPEN:
            open += 1
        else:
            open -= 1
        if open <0:
            return False
    return open == 0


assert task("(())()") is True
assert task("(()))()") is False

if __name__ == "__main__":
    args = read_input()
    yes = task(*args)
    print("YES" if yes else "NO")
