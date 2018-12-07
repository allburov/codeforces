import time


def timeit(method):
    def timed(*args, **kw):
        ts = time.time()
        try:
            result = method(*args, **kw)
            return result
        finally:
            te = time.time()
            print('%r (%r, %r) %2.2f sec' % (method.__name__, args, kw, te - ts))

    return timed


def parse_in(filename="maze.in", content=None):
    if content is None:
        with open(filename) as f:
            content = f.readlines()

    line_ = content[0].strip('\n ')
    vertex = int(line_.split(' ')[0])
    INF = None
    adj_m = [[INF for _ in range(vertex)] for _ in range(vertex)]
    for line in content[1:]:
        line = line.strip('\n ')
        start, end, weight = line.split(" ")
        start = int(start)
        end = int(end)
        weight = int(weight)
        if adj_m[start - 1][end - 1] is None or adj_m[start - 1][end - 1] < weight:
            adj_m[start - 1][end - 1] = weight
    return adj_m


def dump_out(answer, filename="maze.out"):
    str_ = str(answer)
    with open(filename, 'w') as f:
        f.write(str_)


def answer_func(distances):
    N = len(distances)
    nodes = [i for i in range(N)]
    answer = 0

    Tsort = []  # топологическая сортировка
    vertex_in = {}  # Входящие вершины в каждую вершину
    for vertex in range(N):
        vertex_in[vertex] = set((u for u in range(N) if distances[u][vertex] is not None))

    start = 0
    end = N

    while True:
        v = next((x for x in vertex_in if not vertex_in[x]), None)
        if v is None:
            return ":)"

        if v >= start:
            Tsort.append(v)
        if v == end - 1:
            break

        v_out_to = [i for i, weight in enumerate(distances[v]) if weight is not None]
        for j in v_out_to:
            vertex_in[j].remove(v)

        vertex_in.pop(v)
        if not vertex_in:
            break

    max_dist = {i: 0 for i in Tsort}

    vertex_in = {}
    for vertex in Tsort:
        vertex_in[vertex] = set((u for u in Tsort if distances[u][vertex] is not None))

    for v in Tsort:
        all_distance = [distances[u][v] + max_dist[u] for u in vertex_in[v]]
        if all_distance:
            max_dist[v] = max(all_distance)

    answer = max_dist[end - 1]
    return answer


def ford_bellmana(distances):
    N = len(distances)
    nodes = [i for i in range(N)]
    answer = []
    INF = 2

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


def sum_dist(distances):
    answer = 0
    for i in range(len(distances)):
        for j in range(len(distances)):
            if j < i: continue
            answer += distances[i][j]
    return answer


@timeit
def main():
    adj_m = parse_in()
    answer = answer_func(adj_m)

    dump_out(answer)

if __name__ == "__main__":
    main()
