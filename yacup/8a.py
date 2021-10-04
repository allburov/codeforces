def read_input():
    with open("input.txt") as input_:
        line = input_.readline()
        line = line.strip("\n")
        while line:
            if line == "PRINTTREE":
                yield line, 0
            else:
                operation, number = line.split(" ")
                number = int(number)
                yield operation, number
            line = input_.readline()
            line = line.strip("\n")


DONE = "DONE"
ALREADY = "ALREADY"
YES = "YES"
NO = "NO"


class Node:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None


class Solver:
    def __init__(self):
        self.root = None

    def add(self, number):
        node = Node(number)
        if self.root is None:
            self.root = node
            return DONE

        root: Node = self.root
        while True:
            if root.value == number:
                return ALREADY
            elif root.value < number:
                if root.right is None:
                    root.right = node
                    return DONE
                root = root.right
            elif root.value > number:
                if root.left is None:
                    root.left = node
                    return DONE
                root = root.left

    def search(self, number):
        root = self.root
        while root:
            if root.value == number:
                return YES
            elif root.value < number:
                root = root.right
            elif root.value > number:
                root = root.left
        return NO

    @classmethod
    def printtree(cls, root, depth):
        if root is None:
            return
        cls.printtree(root.left, depth+1)
        print("."*depth + str(root.value))
        cls.printtree(root.right, depth+1)


def main():
    iterator = read_input()
    solver = Solver()
    for op, number in iterator:
        if op == "PRINTTREE":
            Solver.printtree(solver.root, depth=0)
            continue
        elif op == "ADD":
            res = solver.add(number)
        elif op == "SEARCH":
            res = solver.search(number)
        else:
            raise ValueError(f"unknown op={op}")
        print(res)


if __name__ == "__main__":
    main()
