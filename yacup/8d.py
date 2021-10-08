import sys
from collections import defaultdict


def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        points = []
        for i in range(n - 1):
            points.append(tuple(map(int, input_.readline().split())))
    return points,


sys.setrecursionlimit(3000)


def task(points):
    if not points:
        return 1
    graph = defaultdict(set)
    for s1, s2 in points:
        graph[s1].add(s2)
        graph[s2].add(s1)

    visited = set()

    def dfs(point):
        visited.add(point)
        heights = []
        maxDiameter = 1

        for neig in graph[point]:
            if neig in visited:
                continue
            d, h = dfs(neig)
            maxDiameter = max(maxDiameter, d)
            heights.append(h)
        if not heights:
            return 1, 1

        if len(heights) > 1:
            possibleDiameters = [0]
            le = len(heights)
            for i in range(le):
                for j in range(i + 1, le):
                    possibleDiameters.append(heights[i] + heights[j])
            maxPossibleDiameter = max(possibleDiameters) + 1
        else:
            maxPossibleDiameter = heights[0] + 1

        currentDiameter = max(maxDiameter, maxPossibleDiameter)
        currentHeight = max(heights) + 1
        return currentDiameter, currentHeight

    diameter, height = dfs(points[0][0])
    return diameter


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
