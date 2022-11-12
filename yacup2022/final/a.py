import itertools
import json
import re
import sys
from collections import defaultdict
from heapq import heappush, heappop
from typing import List, Set, Any, Dict


def read_input():
    with open('./input.txt') as input_:
        data = json.loads(input_.readline())
        solver = Solver(data)
        q = int(input_.readline().strip("\n"))
        for _ in range(q):
            query = json.loads(input_.readline())
            result = solver.solve(**query)
            print(json.dumps({"result": result}))


class Solver:
    def __init__(self, data):
        self.values: Dict[str, Any] = {}
        self._prepare(data, path="")

    def _prepare(self, data, path):
        for key, value in data.items():
            if value is None:
                continue
            npath = f"{path}.{key}"
            if isinstance(value, dict):
                self._prepare(value, npath)
            else:
                self.values[npath] = value


    def solve(self, path, count):
        repath = re.escape(path)
        repath = repath.replace("\\*", ".*")
        regexp = re.compile("\\." + repath + "$")
        result = []
        has_int = False
        has_str = False
        for key, value in self.values.items():
            if not regexp.match(key):
                continue
            result.append(value)
            if isinstance(value, int):
                has_int = True
            if isinstance(value, str):
                has_str = True
            if has_int and has_str:
                return None

        result.sort(reverse=True)
        return result[:count]



def main():
    read_input()


if __name__ == "__main__":
    main()
