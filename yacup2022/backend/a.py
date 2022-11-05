import itertools
import sys
from collections import defaultdict
from heapq import heappush, heappop
from typing import List, Set



class PQ:
    def __init__(self):
        self.pq = []  # list of entries arranged in a heap
        self.entry_finder = {}  # mapping of tasks to entries
        self.REMOVED = sys.maxsize  # placeholder for a removed task
        self.counter = itertools.count()

    def add_task(self, task, priority=0):
        'Add a new task or update the priority of an existing task'
        assert task >= 0
        if task in self.entry_finder:
            self.remove_task(task)
        count = next(self.counter)
        entry = [priority, task, count, task]
        self.entry_finder[task] = entry
        heappush(self.pq, entry)

    def remove_task(self, task):
        'Mark an existing task as REMOVED.  Raise KeyError if not found.'
        entry = self.entry_finder.pop(task)
        entry[-1] = self.REMOVED

    def pop_task(self):
        'Remove and return the lowest priority task. Raise KeyError if empty.'
        while self.pq:
            priority, task, count, flag = heappop(self.pq)
            if flag != self.REMOVED:
                del self.entry_finder[task]
                return task, priority
        raise KeyError('pop from an empty priority queue')


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

        self.heapmax = PQ()
        self.heapmin = PQ()
        for i in range(n):
            self._set(i)

    def _set(self, datacenter):
        R = self.resets[datacenter]
        A = self.m - len(self.datacenters[datacenter])
        value = R * A
        self.heapmax.add_task(task=datacenter, priority=-value)
        self.heapmin.add_task(task=datacenter, priority=value)

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
        datacenter, priority = self.heapmax.pop_task()
        print(datacenter + 1)
        self.heapmax.add_task(task=datacenter, priority=priority)

    def getmin(self):
        datacenter, priority = self.heapmin.pop_task()
        print(datacenter + 1)
        self.heapmin.add_task(task=datacenter, priority=priority)


def main():
    read_input()


if __name__ == "__main__":
    main()
