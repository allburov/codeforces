from collections import defaultdict


def read_input():
    with open('input.txt') as input_:
        N = int(input_.readline())
        for _ in range(N):
            answer_for = int(input_.readline())
            if answer_for == 0:
                theme = input_.readline()
                msg = input_.readline()
                yield answer_for, theme, msg
            else:
                msg = input_.readline()
                yield answer_for, None, msg


class Solver:
    def __init__(self):
        self._counter = defaultdict(int)
        self._theme_for_msg = {}
        self._themes = []

    def msg(self, i, answer_for):
        theme = self._theme_for_msg[answer_for]
        self._theme_for_msg[i] = theme
        self._counter[theme] += 1

    def topic(self, i, theme):
        self._themes.append(theme)
        self._theme_for_msg[i] = theme
        self.msg(i, i)

    def result(self):
        if not self._counter:
            return
        max_ = max(self._counter.values())
        for theme in self._themes:
            if self._counter[theme] == max_:
                return theme

def main():
    solver = Solver()
    for i, (answer_for, theme, msg) in enumerate(read_input(), start=1):
        if answer_for == 0:
            solver.topic(i, theme)
        else:
            solver.msg(i, answer_for)

    answer = solver.result()
    if answer:
        print(answer)

if __name__ == "__main__":
    main()
