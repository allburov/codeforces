from fractions import Fraction


def read_input():
    with open('input.txt') as input_:
        N = int(input_.readline())
        nums = []
        for _ in range(N):
            num = list(map(int, input_.readline().split()))
            nums.append(num)
    return nums


class Point():
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __str__(self):
        return f"({self.x},{self.y})"


def is_parallelogram(p1: Point, p2: Point, p3: Point, p4: Point):
    return all([
        slope(p1, p2) == slope(p3, p4),
        slope(p1, p4) == slope(p2, p3),
    ])


def square_distance_to_0(p: Point):
    return p.x ** 2 + p.y ** 2


def slope(p1: Point, p2: Point):
    if square_distance_to_0(p1) > square_distance_to_0(p2):
        p1, p2 = p2, p1

    if p2.x - p1.x == 0:
        return float('inf')

    return Fraction(p2.y - p1.y, p2.x - p1.x)


def task(*points):
    from itertools import permutations
    for variant in permutations(points):
        if is_parallelogram(*variant):
            return "YES"
    return "NO"


points = [Point(-5, -11), Point(-5, -1), Point(0, 0), Point(0, -10)]
assert task(*points) == "YES"

if __name__ == "__main__":
    args = read_input()
    for num in args:
        points = [Point(num[2 * i], num[2 * i + 1]) for i in range(4)]
        answer = task(*points)
        print(answer)
