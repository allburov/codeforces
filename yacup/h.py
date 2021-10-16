from collections import defaultdict
from heapq import heappush, heappop

SERVER = 1
PORT = 2


def read_input():
    with open('input.txt') as input_:
        n, m = tuple(map(int, input_.readline().split()))
        r = int(input_.readline())
        rules = []
        for _ in range(r):
            rule = tuple(map(int, input_.readline().split()))
            rules.append(rule)
    return n, m, rules


S = "s"
P = "p"


def task(n, m, rules):
    graph = defaultdict(set)
    result = []
    for rule in rules:
        if rule[0] == SERVER:
            _, server, p = rule
            for port in range(1, p + 1):
                graph[(S, server)].add((P, port))
                graph[(P, port)].add((S, server))

        if rule[0] == PORT:
            _, port, s = rule
            for server in range(1, s + 1):
                graph[(S, server)].add((P, port))
                graph[(P, port)].add((S, server))

    pq = []
    for node in graph:
        heappush(pq, (-len(graph[node]), node))

    while pq:
        level, node = heappop(pq)
        if level != -len(graph[node]):
            continue



    return result


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
