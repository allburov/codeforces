import sys


def read_input():
    with open('input.txt') as input_:
        m = int(input_.readline())

        segments = []
        segment = tuple(map(int, input_.readline().split()))
        while segment != (0, 0):
            segments.append(segment)
            segment = tuple(map(int, input_.readline().split()))
    return m, segments


NO_SOLUTION = "No solution"

START = 0
END = 1

TOO_SMALL_SEGMENT = (-sys.maxsize, -sys.maxsize)


def task(m, segments):
    n = len(segments)
    segments.sort()
    current_segment = (segments[0][START], 0)
    answer = []
    current_pos = -1

    def get_biggest(from_pos, before_segment):
        the_biggest, pos = TOO_SMALL_SEGMENT, -1
        for i in range(from_pos + 1, n):
            segment = segments[i]
            if segment[START] > before_segment[END]:
                break
            if segment[END] > the_biggest[END]:
                the_biggest = segment
                pos = i
        return the_biggest, pos

    while m > current_segment[END]:
        biggest_segment, pos_biggest = get_biggest(
            from_pos=current_pos,
            before_segment=current_segment,
        )
        if pos_biggest == -1:
            return None
        current_pos = pos_biggest
        current_segment = biggest_segment
        answer.append(current_segment)

    return answer


def main():
    args = read_input()
    res = task(*args)
    if res is None:
        print(NO_SOLUTION)
        return
    print(len(res))
    print("\n".join(f"{x[0]} {x[1]}" for x in res))


if __name__ == "__main__":
    main()
