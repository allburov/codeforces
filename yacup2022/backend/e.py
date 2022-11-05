import sys
from collections import Counter
from typing import Dict, List
sys.setrecursionlimit(1000000)


def read_input():
    solver = Solver()
    with open('./input.txt') as input_:
        n = int(input_.readline())
        for _ in range(n):
            data = input_.readline()
            data = data.rstrip("\n")
            solver.block(data)

        m = int(input_.readline())
        for _ in range(m):
            data = input_.readline()
            data = data.rstrip("\n")
            solver.add(data)

        solver.block_all(solver.root)
        solver.sum(solver.root)

        q = int(input_.readline())
        for _ in range(q):
            data = input_.readline()
            data = data.rstrip("\n")
            solver.query(data)


def create_folder(name):
    return dict(name=name, child={}, files=Counter(), block=False)


def upsert_subfolder(parent: Dict, name):
    if name in parent['child']:
        return parent['child'][name]

    new = create_folder(name)
    parent['child'][name] = new
    return new


def parse(path):
    if path == "/":
        return []
    return path.strip("/").split('/')


def getfolder(parent, parts: List[str]):
    parts = list(reversed(parts))

    while parts:
        name = parts.pop()
        if name not in parent['child']:
            return None
        parent = parent['child'][name]

    return parent


def get(root, foldername):
    if isinstance(foldername, str):
        parts = parse(foldername)
    else:
        parts = foldername
    parent = root
    for part in parts:
        parent = upsert_subfolder(parent, part)
    return parent


class Solver:
    def __init__(self):
        self.root = create_folder("/")

    def block(self, foldername):
        folder = get(self.root, foldername)
        folder['block'] = True

    def add(self, filepath):
        *parts, filename = parse(filepath)
        folder = get(self.root, parts)
        name, ext = filename.rsplit(".", maxsplit=1)
        folder['files'][ext] += 1

    def block_all(self, parent):
        for children in parent['child'].values():
            if parent['block']:
                children['block'] = True
            self.block_all(children)

    def sum(self, parent):
        for children in parent['child'].values():
            self.sum(children)

        if not parent['block']:
            parent['files'] = Counter()

        for children in parent['child'].values():
            parent['files'] += children['files']

    def query(self, foldername):
        folder = get(self.root, foldername)
        files: Counter = folder['files']

        print(len(files.keys()))
        for ext, counter in files.items():
            print(f".{ext}: {counter}")


def main():
    read_input()


if __name__ == "__main__":
    main()
