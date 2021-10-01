def read_input():
    with open('../input.txt') as input_:
        n, m = tuple(map(int, input_.readline().split()))
    return n, m


def merge(matrix, n, m, unique):
    if n < m:
        return mergeVer(matrix, n, m, unique)
    return mergeHor(matrix, n, m, unique)


def mergeVer(matrix, n, m, unique):
    for i in range(n):
        next_m = m // 2
        for j in range(next_m):
            at = i * m + j
            plus_at = (i + 1) * m - j - 1
            matrix[at] += matrix[plus_at]
            unique.add(matrix[at])
    return n, next_m


def mergeHor(matrix, n, m, unique):
    next_n = n // 2
    for i in range(next_n):
        for j in range(m):
            at = i * m + j
            plus_at = (n - 1 - i) * m + j
            matrix[at] += matrix[plus_at]
            unique.add(matrix[at])
    return next_n, m


def task(n, m):
    matrix = [i for i in range(1, n * m + 1)]
    unique_number = set(matrix)
    while (n, m) != (1, 1):
        n, m = merge(matrix, n, m, unique_number)
    return len(unique_number)


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
