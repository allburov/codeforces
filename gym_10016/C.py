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

    Tsort = []  # топологическая сортировка
    vertex_in = {}  # Входящие вершины в каждую вершину
    vertex_in_Tsort = {}
    max_dist = {}
    for vertex in range(N):
        vertex_in[vertex] = set((u for u in range(N) if distances[u][vertex] is not None))

    start = 0
    end = N

    while True:
        vertex = next((x for x in vertex_in if not vertex_in[x]), None)
        if vertex is None:
            return ":)"

        if vertex >= start:
            Tsort.append(vertex)
            max_dist[vertex] = 0
            vertex_in_Tsort[vertex] = set((u for u in Tsort if distances[u][vertex] is not None))
            all_distance = [distances[u][vertex] + max_dist[u] for u in vertex_in_Tsort[vertex]]
            if all_distance:
                max_dist[vertex] = max(all_distance)
        if vertex == end - 1:
            break

        v_out_to = [i for i, weight in enumerate(distances[vertex]) if weight is not None]
        for j in v_out_to:
            vertex_in[j].remove(vertex)

        vertex_in.pop(vertex)
        if not vertex_in:
            break

    answer = max_dist[end - 1]
    return answer


@timeit
def main():
    adj_m = parse_in()
    answer = answer_func(adj_m)

    dump_out(answer)


if __name__ == "__main__":
    main()
