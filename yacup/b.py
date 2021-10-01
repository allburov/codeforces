from collections import Counter


def read_input():
    with open('input.txt') as input_:
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

MAPPER = {
    # BB
    # BB
    ("BB", "BB"): 0,
    # BB
    # BW
    ("BB", "BW"): 1,
    ("BB", "WB"): 1,
    ("WB", "BB"): 1,
    ("BW", "BB"): 1,
    # BB
    # WW
    ("BB", "WW"): 3,
    ("WB", "WB"): 3,
    ("WW", "BB"): 3,
    ("BW", "BW"): 3,
    # BW
    # WB
    ("BW", "WB"): 5,
    ("WB", "BW"): 5,

    # WW
    # WB
    ("WW", "WB"): 7,
    ("WW", "BW"): 7,
    ("BW", "WW"): 7,
    ("WB", "WW"): 7,

    # WW
    # BW
    ("WW", "BW"): 7,

    # WW
    # WW
    ("WW", "WW"): 15,

    "WBWB": 5,
    "BWBW": 5,
    "WWWW": 15,
}


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
