def read_input():
    with open('input.txt') as input_:
        lines = input_.readlines()
        words = []
        for line in lines:
            words.extend(line.split())
    return (words,)

def sort_by(x):
    return -x[1], x[0]

def task(words):
    from collections import defaultdict
    sums = defaultdict(int)
    for word in words:
        sums[word] += 1

    return list(word for word, num in sorted(sums.items(), key=sort_by))


if __name__ == "__main__":
    args = read_input()
    answer = task(*args)
    print("\n".join(answer))
