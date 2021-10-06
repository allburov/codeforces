def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
    return n,


def task(n):
    answer = []

    def dfs(pattern, not_closed, left):
        if left == 0:
            answer.append(pattern)
            return

        # (
        if not_closed + 1 <= left:
            dfs(pattern + "(", not_closed + 1, left - 1)
        # )
        if not_closed > 0 and left >= 1:
            dfs(pattern + ")", not_closed - 1, left - 1)

    dfs("", 0, n * 2)
    answer.sort()
    return answer


def main():
    args = read_input()
    res = task(*args)
    print("\n".join(res))


if __name__ == "__main__":
    main()
