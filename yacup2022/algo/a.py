import itertools
import sys
from collections import defaultdict
from heapq import heappush, heappop
from typing import List, Set




def read_input():
    with open('./input.txt') as input_:
        n, k = tuple(map(int, input_.readline().split()))
        solver = Solver(n, k)
        result = solver
        if not result:
            print("No")
            return

        print("Yes")
        print(result)


class Solver:
    def __init__(self, n, k):
        self.n = n
        self.k = k

    def solve(self):
        pass


def main():
    read_input()


if __name__ == "__main__":
    main()
