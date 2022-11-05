from collections import defaultdict
from typing import List, Set

try:
    from collections.abc import MutableMapping
except ImportError:
    from collections import MutableMapping


def doc(s):
    if hasattr(s, '__call__'):
        s = s.__doc__

    def f(g):
        g.__doc__ = s
        return g

    return f


class heapdict(MutableMapping):
    __marker = object()

    def __init__(self, *args, **kw):
        self.heap = []
        self.d = {}
        self.update(*args, **kw)

    @doc(dict.clear)
    def clear(self):
        del self.heap[:]
        self.d.clear()

    @doc(dict.__setitem__)
    def __setitem__(self, key, value):
        if key in self.d:
            self.pop(key)
        wrapper = [value, key, len(self)]
        self.d[key] = wrapper
        self.heap.append(wrapper)
        self._decrease_key(len(self.heap) - 1)

    def _min_heapify(self, i):
        n = len(self.heap)
        h = self.heap
        while True:
            # calculate the offset of the left child
            l = (i << 1) + 1
            # calculate the offset of the right child
            r = (i + 1) << 1
            if l < n and h[l][0] < h[i][0]:
                low = l
            else:
                low = i
            if r < n and h[r][0] < h[low][0]:
                low = r

            if low == i:
                break

            self._swap(i, low)
            i = low

    def _decrease_key(self, i):
        while i:
            # calculate the offset of the parent
            parent = (i - 1) >> 1
            if self.heap[parent][0] < self.heap[i][0]:
                break
            self._swap(i, parent)
            i = parent

    def _swap(self, i, j):
        h = self.heap
        h[i], h[j] = h[j], h[i]
        h[i][2] = i
        h[j][2] = j

    @doc(dict.__delitem__)
    def __delitem__(self, key):
        wrapper = self.d[key]
        while wrapper[2]:
            # calculate the offset of the parent
            parentpos = (wrapper[2] - 1) >> 1
            parent = self.heap[parentpos]
            self._swap(wrapper[2], parent[2])
        self.popitem()

    @doc(dict.__getitem__)
    def __getitem__(self, key):
        return self.d[key][0]

    @doc(dict.__iter__)
    def __iter__(self):
        return iter(self.d)

    def popitem(self):
        """D.popitem() -> (k, v), remove and return the (key, value) pair with lowest\nvalue; but raise KeyError if D is empty."""
        wrapper = self.heap[0]
        if len(self.heap) == 1:
            self.heap.pop()
        else:
            self.heap[0] = self.heap.pop()
            self.heap[0][2] = 0
            self._min_heapify(0)
        del self.d[wrapper[1]]
        return wrapper[1], wrapper[0]

    @doc(dict.__len__)
    def __len__(self):
        return len(self.d)

    def peekitem(self):
        """D.peekitem() -> (k, v), return the (key, value) pair with lowest value;\n but raise KeyError if D is empty."""
        return (self.heap[0][1], self.heap[0][0])


def read_input():
    with open('./input.txt') as input_:
        n, m, q = tuple(map(int, input_.readline().split()))
        solver = Solver(n, m)
        for _ in range(q):
            data = input_.readline()
            data = data.strip("\n")
            solver.process(data)


class Solver:
    def __init__(self, n, m):
        self.n = n
        self.m = m

        # Disabled servers by DC
        self.datacenters: List[Set] = [set() for _ in range(n)]
        self.resets = defaultdict(int)

        self.heapmin = heapdict()
        self.heapmax = heapdict()
        for i in range(n - 1, -1, -1):
            self._set(i)

    def _set(self, datacenter):
        R = self.resets[datacenter]
        A = self.m - len(self.datacenters[datacenter])
        value = R * A
        self.heapmin[datacenter] = value
        self.heapmax[datacenter] = -value

    def process(self, event_data):
        parts = event_data.split(" ")
        event = parts[0]

        if event == "DISABLE":
            self.disable(int(parts[1]) - 1, int(parts[2]) - 1)
        elif event == "RESET":
            self.reset(int(parts[1]) - 1)
        elif event == "GETMAX":
            self.getmax()
        elif event == "GETMIN":
            self.getmin()
        else:
            pass

    def reset(self, datacenter):
        self.datacenters[datacenter] = set()
        self.resets[datacenter] += 1
        self._set(datacenter)

    def disable(self, datacenter, server):
        self.datacenters[datacenter].add(server)
        self._set(datacenter)

    def getmax(self):
        datacenter = get(self.heapmax)
        print(datacenter + 1)
        return datacenter + 1

    def getmin(self):
        datacenter = get(self.heapmin)
        print(datacenter + 1)
        return datacenter + 1


def get(heap: heapdict):
    pairs = []
    key, value = heap.popitem()
    pairs.append((key, value))
    while heap and value == heap.peekitem()[1]:
        pairs.append(heap.popitem())

    result = min(pair[0] for pair in pairs)
    # Push them back
    for key, value in pairs:
        heap[key] = value

    return result


def main():
    read_input()


if __name__ == "__main__":
    main()
