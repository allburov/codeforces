END = 0
LOOK = 1
START = 2


def read_input():
    with open('input.txt') as input_:
        n, t = tuple(map(int, input_.readline().split()))
        meets = []
        for i in range(n):
            k = int(input_.readline())
            for _ in range(k):
                line = input_.readline().strip("\n")
                start, end = line.split("-")
                start = tuple(map(int, start.split(":")))
                end = tuple(map(int, end.split(":")))
                meets.append((time_to_minutes(*start), START, i))
                meets.append((time_to_minutes(*end), END, i))

    return n, t, meets


def time_to_minutes(hour, minute):
    return hour * 60 + minute


def minutes_to_time(minutes):
    return minutes // 60, minutes % 60


HALF = 30

NO_WAY = "No way"

def task(n, t, meets):
    result = []
    busy = 0

    times = []
    for i in range(10, 20):
        times.append((i, 0))
        times.append((i, 30))
    times.append((20, 0))
    for time in times:
        meets.append((time_to_minutes(*time), LOOK, 0))

    start = None
    meets.sort()
    for time, event, _ in meets:
        time_minutes = time
        if event == START:
            busy += 1
        elif event == END:
            busy -= 1

        elif event == LOOK:
            if busy != 0:
                start = None

            elif busy == 0 and start is None:
                start = time_minutes

            elif busy == 0 and start:
                if time_minutes - start >= t:
                    result.append((minutes_to_time(start), minutes_to_time(time_minutes)))
                    start += HALF

    return result


def print_time(time):
    if time[1] == 0:
        return f"{time[0]}:00"
    return f"{time[0]}:{time[1]}"


def main():
    args = read_input()
    res = task(*args)
    if not res:
        print(NO_WAY)
    for time in res:
        print(f"{print_time(time[0])}-{print_time(time[1])}")


if __name__ == "__main__":
    main()
