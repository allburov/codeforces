import time

from typing import List


def timeit(method):
    def timed(*args, **kw):
        ts = time.time()
        try:
            result = method(*args, **kw)
            return result
        finally:
            te = time.time()
            # print('%r (%r, %r) %2.2f sec' % (method.__name__, args, kw, te - ts))
            print('%r %2.2f sec' % (method.__name__, te - ts))

    return timed


@timeit
def main(in_):
    in_list = in_.splitlines()  # type: List
    vertexs = int(in_list.pop(0))
    k = int(in_list.pop(0))
    exits = {x for x in map(int, in_list.pop(0).strip(' ').split(' '))}

    distances = [set() for _ in range(vertexs+1)]
    distances[0] = exits
    for e in exits:
        distances[e].add(0)
    in_list.pop(0)
    for line in in_list:
        line = line.strip('\n ')
        start, end = map(int, line.split(" "))
        distances[start].add(end)
        distances[end].add(start)

    distances_m = bfs(distances)

    answer = []
    for i in range(1, vertexs+1):
        answer.append(str(distances_m[i]))
    return " ".join(map(str, answer)) + ' '


def bfs(distances):
    vertexs = len(distances)
    visited = {0: True}  # using None as +inf
    visited[0] = True
    level = []
    i = 0
    level.append([0])
    while level[i]:
        level.append([])
        for node in level[i]:
            for neighbour in distances[node]:
                if neighbour not in visited:
                    visited[neighbour] = i
                    level[i + 1].append(neighbour)
                    distances[neighbour].remove(node)
        i = i + 1
    return visited


if __name__ == "__main__":
    NUMBER = "06"
    with open('tests/g/{}'.format(NUMBER), 'r') as f:
        in_ = f.read()
    out_ = main(in_)
    with open('tests/g/{}.a'.format(NUMBER), 'r') as f:
        out_expect = f.readlines()[0].strip('\n')
    assert out_ == out_expect
