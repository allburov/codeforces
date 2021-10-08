from collections import defaultdict, deque


def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        cities = []
        for i in range(n):
            city = tuple(map(int, input_.readline().split()))
            cities.append(city)
        k = int(input_.readline())
        start, end = tuple(map(int, input_.readline().split()))
    return n, cities, k, start, end


def distance(city1, city2):
    return abs(city1[0] - city2[0]) + abs(city1[1] - city2[1])


def task(n, cities, k, start, end):
    start -=1
    end -=1
    graph = defaultdict(set)

    for i1, city1 in enumerate(cities):
        for i2, city2 in enumerate(cities):
            if distance(city1, city2) <= k:
                graph[i1].add(i2)

    def bfs():
        q = deque()
        q.append((start, 0))
        visited = set()
        while q:
            city, d = q.popleft()
            if city in visited:
                continue
            visited.add(city)

            if city == end:
                return d

            for neigh in graph[city]:
                q.append((neigh, d + 1))

    res = bfs()
    return res or -1


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
