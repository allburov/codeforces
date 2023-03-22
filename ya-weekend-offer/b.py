from dataclasses import dataclass
from datetime import datetime

END = 0
LOOK = 1
START = 2


def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        payments = []
        for i in range(n):
            line = input_.readline().split()
            amount, start, finish = int(line[0]), line[1], line[2]
            payments.append((amount, start, finish))
    return payments


@dataclass
class Quarter:
    start: datetime
    finish: datetime

    def number_of_days(self, start, finish):
        if finish < self.start:
            return 0
        if self.finish < start:
            return 0
        # More than quarter
        if start < self.start and finish > self.finish:
            return (self.finish - self.start).days + 1
        # Inside
        if start >= self.start and finish <= self.finish:
            return (finish - start).days + 1
        # Left
        if start < self.start and finish >= self.start:
            the_finish = min(finish, self.finish)
            return (the_finish - self.start).days + 1
        # Right
        if finish > self.finish and start <= self.finish:
            the_start = max(start, self.start)
            return (self.finish - the_start).days + 1
        raise ValueError("Not found")


QUARTERS = [
    Quarter(
        start=datetime(2022, 1, 1),
        finish=datetime(2022, 3, 31),
    ),
    Quarter(
        start=datetime(2022, 4, 1),
        finish=datetime(2022, 6, 30),
    ),
    Quarter(
        start=datetime(2022, 7, 1),
        finish=datetime(2022, 9, 30),
    ),
    Quarter(
        start=datetime(2022, 10, 1),
        finish=datetime(2022, 12, 31),
    ),
]


def to_datetime(string):
    parts = string.split(".")
    return datetime(2022, month=int(parts[1]), day=int(parts[0]))


def task(payments):
    quarters = {}
    for q in QUARTERS:
        quarters[(q.start, q.finish)] = 0

    for amount, start, finish in payments:
        start = to_datetime(start)
        finish = to_datetime(finish)
        interval = finish - start
        amount_avg = int(amount * 100 / (interval.days + 1))
        for q in QUARTERS:
            days = q.number_of_days(start, finish)
            if days:
                quarters[(q.start, q.finish)] += days * amount_avg

    return quarters.values()


def main():
    args = read_input()
    res = task(args)
    for r in res:
        r = r / 100
        print(f"{r:.2f}")


if __name__ == "__main__":
    main()
