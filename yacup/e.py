from collections import defaultdict
from datetime import datetime

FORMAT = "%Y-%m-%d"


def read_input():
    with open('input.txt') as input_:
        line = input_.readline().strip()
        while line:
            stock, start_end, type = line.split(",")
            start, end = start_end.split(" ")
            type = type.strip()
            yield stock, datetime.strptime(start, FORMAT), datetime.strptime(end, FORMAT), type
            line = input_.readline().strip()


KGT = "KGT"
COLD = "COLD"
OTHER = "OTHER"
NULL = "NULL"

START = 0
END = 1


class Solver:
    def __init__(self):
        self.stocks = defaultdict(lambda: defaultdict(list))

    def fill(self, stock, start, end, type):
        if type == NULL:
            types = (KGT, COLD, OTHER)
        else:
            types = (type,)

        for t in types:
            self.stocks[stock][t].append((start, START))
            self.stocks[stock][t].append((end, END))

    def get(self):
        for i in range(10):
            i = str(i)
            if i not in self.stocks:
                continue
            for type in (KGT, COLD, OTHER):
                if type not in self.stocks[i]:
                    continue

                events = sorted(self.stocks[i][type])
                opened_at: datetime = None
                count = 0
                for time, event in events:
                    if event == START:
                        if count == 0:
                            opened_at = time
                        count += 1
                    elif event == END:
                        count -= 1
                        if count == 0:
                            start_date = opened_at.strftime(FORMAT)
                            end_date = time.strftime(FORMAT)
                            yield f"{i},{start_date} {end_date},{type}"
                            opened_at = None
                    else:
                        raise ValueError(f"Uknownd event = {event}")


def main():
    iterator = read_input()
    solver = Solver()
    for args in iterator:
        solver.fill(*args)

    res = solver.get()
    print("\n".join(res))


if __name__ == "__main__":
    main()
