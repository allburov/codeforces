import heapq
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


def parse_in(filename="sumdist.in", content=None):
    if content is None:
        with open(filename) as f:
            content = f.readlines()

    line_ = content[0].strip('\n ')
    vertex = int(line_.split(' ')[0])
    INF = None
    adj_m = [[INF for _ in range(vertex)] for _ in range(vertex)]
    for line in content[1:]:
        line = line.strip('\n ')
        start, end = line.split(" ")
        start = int(start)
        end = int(end)
        adj_m[start - 1][end - 1] = 1
        adj_m[end - 1][start - 1] = 1
    return adj_m


def dump_out(answer, filename="sumdist.out"):
    str_ = str(answer)
    with open(filename, 'w') as f:
        f.write(str_)


def dejkstra(distances):
    N = len(distances)
    N2 = N * N
    nodes = [i for i in range(N)]
    answer = [[None for _ in range(N)] for _ in range(N)]
    answer_count = 0

    for node in nodes:
        current = node
        visited = {}
        unvisited = {node: None for node in nodes}  # using None as +inf
        candidates_h = []
        current_distance = 0
        unvisited[current] = current_distance

        heapq.heappush(candidates_h, (current_distance, current))
        while True:
            # candidates = [node for node in unvisited.items() if node[1] is not None]
            # current, current_distance = sorted(candidates, key=lambda x: x[1])[0]
            current_distance, current = heapq.heappop(candidates_h)
            for neighbour, distance in enumerate(distances[current]):
                if neighbour in visited:
                    continue
                if distance is None: continue
                new_distance = current_distance + distance
                if unvisited[neighbour] is None or unvisited[neighbour] > new_distance:
                    try:
                        candidates_h.remove((neighbour, unvisited[neighbour]))
                    except:
                        pass
                    heapq.heappush(candidates_h, (new_distance, neighbour))

                    unvisited[neighbour] = new_distance
            visited[current] = current_distance
            answer[node][current] = current_distance
            del unvisited[current]
            if not unvisited: break

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
    dist = dejkstra(adj_m)
    answer = sum_dist(dist)

    dump_out(answer)

    # До оптимизации - ~ 20-30 секунд на 400 полносвязном графе


if __name__ == "__main__":
    main()
