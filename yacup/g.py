from collections import deque


def read_input():
    with open("input.txt") as input_:
        n = int(input_.readline())
        nodes_limit = []
        edges = []
        for _ in range(n):
            i, l = tuple(map(int, input_.readline().split()))
            nodes_limit.append((i, l))
        for _ in range(n - 1):
            f, t = tuple(map(int, input_.readline().split()))
            edges.append((f, t))
        yield nodes_limit, edges
        m = int(input_.readline())
        for _ in range(m):
            i, d = tuple(map(int, input_.readline().split()))
            yield (i, d)


GREEN = 0
RED = 1


def node(id, count, limit):
    return dict(id=id, count=count, limit=limit, children=[], color=GREEN, parent=None)


class Solver:
    def __init__(self, nodes_limit, edges):
        self.nodes = {}
        for i, l in nodes_limit:
            self.nodes[i] = node(i, 0, limit=l)

        for f, t in edges:
            self.nodes[f]['children'].append(self.nodes[t])
            self.nodes[t]['parent'] = self.nodes[f]

    def fill(self, i, d):
        node = self.nodes[i]
        was_green_self = node['count'] < node['limit']
        node['count'] += d
        green_self = node['count'] < node['limit']
        if was_green_self == green_self:
            return None

        if node['color'] == GREEN and not green_self:
            return self.recolor(node, RED)

        if node['color'] == RED and green_self:
            if node['parent'] and node['parent']['color'] == RED:
                return None

            return self.recolor(node, GREEN)

    def recolor(self, node, color):
        q = deque()
        q.append(node)
        count = 0
        answer = 0
        while q:
            node = q.pop()
            if color == GREEN:
                green_self = node['count'] < node['limit']
                if not green_self:
                    continue

            answer ^= node['id']
            count += 1
            node['color'] = color
            for child in node['children']:
                if color != child['color']:
                    q.append(child)
        return count, answer


def main():
    iterator = read_input()
    nodes_limit, edges = next(iterator)
    solver = Solver(nodes_limit, edges)

    for i, d in iterator:
        res = solver.fill(i, d)
        if not res:
            print("0 0")
        else:
            print(f"{res[0]} {res[1]}")


if __name__ == "__main__":
    main()
