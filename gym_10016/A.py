def parse_in(filename="floyd.in", content=None):
    adj_m = []
    if content is None:
        with open(filename) as f:
            content = f.readlines()

    count = int(content[0])
    for line in content[1:]:
        line = line.strip('\n ')
        line_m = [int(x) for x in line.split(' ')]
        adj_m.append(line_m)
    assert len(adj_m) == count
    return adj_m


def dump_out(answer, filename="floyd.out"):
    str_ = ""
    for line in answer:
        for int_ in line:
            str_ += str(int_)
            str_ += " "
        str_ += "\n"

    with open(filename, 'w') as f:
        f.write(str_)


def dejkstra(distances):
    N = len(distances)
    nodes = [i for i in range(N)]
    answer = [[None for _ in range(N)] for _ in range(N)]

    for node in nodes:
        current = node
        visited = {}
        unvisited = {node: None for node in nodes}  # using None as +inf
        current_distance = 0
        unvisited[current] = current_distance
        while True:
            for neighbour, distance in enumerate(distances[current]):
                if neighbour in visited:
                    continue
                new_distance = current_distance + distance
                if unvisited[neighbour] is None or unvisited[neighbour] > new_distance:
                    unvisited[neighbour] = new_distance
            visited[current] = current_distance
            answer[node][current] = current_distance
            del unvisited[current]
            if not unvisited: break
            candidates = [node for node in unvisited.items() if node[1] is not None]
            current, current_distance = sorted(candidates, key=lambda x: x[1])[0]

    return answer


def ford_bellmana(distances):
    N = len(distances)
    nodes = [i for i in range(N)]
    answer = []
    INF = 10 ** 9

    for node in nodes:
        dist = [INF] * N
        dist[node] = 0
        for k in range(N):
            for j in range(N):
                for i in range(N):
                    # for j, i in W.keys():
                    if dist[j] + distances[j][i] < dist[i]:
                        dist[i] = dist[j] + distances[j][i]
        answer.append(dist)

    return answer


floyd = ford_bellmana


def main():
    adj_m = parse_in()
    answer = floyd(adj_m)
    dump_out(answer)


if __name__ == "__main__":
    main()
