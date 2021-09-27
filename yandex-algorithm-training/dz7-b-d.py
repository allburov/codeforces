import bisect


def read_input():
    with open('input.txt') as input_:
        n, m = tuple(map(int, input_.readline().split()))
        cats = list(map(int, input_.readline().split()))

        queries = []
        for _ in range(m):
            q = tuple(map(int, input_.readline().split()))
            queries.append(q)
    return cats, queries


def task(cats, queries):
    cats.sort()
    answer = []
    for start, stop in queries:
        start_pos = bisect.bisect_left(cats, start)
        stop_pos = bisect.bisect_right(cats, stop)
        answer.append(str(stop_pos - start_pos) + " ")
    return answer


def main():
    args = read_input()
    res = task(*args)
    print("".join(map(str, res)))


if __name__ == "__main__":
    main()
