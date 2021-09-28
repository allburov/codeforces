EMPTY = 0
WHITE = 1
BLACK = 2


def read_input():
    with open("input.txt") as input_:
        n, m = tuple(map(int, input_.readline().split()))
        square = [[EMPTY] * m for _ in range(n)]

        w = int(input_.readline())
        for _ in range(w):
            i, j = tuple(map(int, input_.readline().split()))
            square[i - 1][j - 1] = WHITE
        b = int(input_.readline())
        for _ in range(b):
            i, j = tuple(map(int, input_.readline().split()))
            square[i - 1][j - 1] = BLACK
        first = input_.readline().strip()
    return square, WHITE if first == "white" else BLACK


def task(square, first):
    enemy = BLACK if first == WHITE else WHITE
    n = len(square)
    m = len(square[0])
    N_RANGE = set(range(n))
    M_RANGE = set(range(m))

    def canEat(i, j):
        if i - 2 in N_RANGE and j - 2 in M_RANGE:
            if square[i - 1][j - 1] == enemy and square[i - 2][j - 2] == EMPTY:
                return True

        if i - 2 in N_RANGE and j + 2 in M_RANGE:
            if square[i - 1][j + 1] == enemy and square[i - 2][j + 2] == EMPTY:
                return True

        if i + 2 in N_RANGE and j + 2 in M_RANGE:
            if square[i + 1][j + 1] == enemy and square[i + 2][j + 2] == EMPTY:
                return True

        if i + 2 in N_RANGE and j - 2 in M_RANGE:
            if square[i + 1][j - 1] == enemy and square[i + 2][j - 2] == EMPTY:
                return True

        return False

    for i in range(n):
        for j in range(m):
            if square[i][j] == first and canEat(i, j):
                return "Yes"
    return "No"


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
