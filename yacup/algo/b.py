from collections import Counter
from itertools import product


def read_input():
    with open('../input.txt') as input_:
        k = int(input_.readline())
        tiles = []
        for _ in range(k):
            first = input_.readline().strip("\n")
            second = input_.readline().strip("\n")
            tile_number = convert(first, second)
            tiles.append(tile_number)
        n, m = tuple(map(int, input_.readline().split()))

        picture = []
        for _ in range(n // 2):
            first = input_.readline().strip("\n")
            second = input_.readline().strip("\n")
            for j in range(m // 2):
                tile_number = convert(first[2 * j:2 * j + 2], second[2 * j:2 * j + 2])
                picture.append(tile_number)
        return tiles, picture


YES = "Yes"
NO = "No"


def get_mapper(letters):
    mapper = {}
    next_value = 1
    variants = ["".join(x) for x in list(product(letters, repeat=2))]

    def get_value(first, bottom):
        for i in range(4):
            if (first, bottom) in mapper:
                return mapper[(first, bottom)]
            (first, bottom) = rotate(first, bottom)
        return None

    for first_v, bottom_v in product(variants, repeat=2):
        value = get_value(first=first_v, bottom=bottom_v)
        if not value:
            for i in range(4):
                mapper[(first_v, bottom_v)] = next_value
                (first_v, bottom_v) = rotate(first_v, bottom_v)
            next_value += 1

    return mapper


def rotate(first, second):
    new_first = second[0] + first[0]
    new_second = second[1] + first[1]
    return new_first, new_second


MAPPER = get_mapper("WBR")


def convert(first, second) -> int:
    return MAPPER[(first, second)]


def task(tiles, picture):
    if len(tiles) < len(picture):
        return NO
    tiles_counter = Counter(tiles)
    picture_counter = Counter(picture)
    empty_in_picture = picture_counter - tiles_counter
    if not empty_in_picture:
        return YES
    return NO


def main():
    args = read_input()
    res = task(*args)
    print(res)


if __name__ == "__main__":
    main()
