def read_input():
    with open('input.txt') as input_:
        n = int(input_.readline())
        delivery_ids = tuple(map(int, input_.readline().split()))
        parent_ids = tuple(map(int, input_.readline().split()))
        k = int(input_.readline())
        if k >= 1:
            not_delivered_yet_ids = tuple(map(int, input_.readline().split()))
        else:
            not_delivered_yet_ids = tuple()

        not_delivered_yet_ids = set(not_delivered_yet_ids)
    return n, delivery_ids, parent_ids, not_delivered_yet_ids


def find(data, i):
    if i != data[i]:
        data[i] = find(data, data[i])
    return data[i]


def union(data, i, j):
    pi, pj = find(data, i), find(data, j)
    if pi != pj:
        data[pi] = pj


def connected(data, i, j):
    return find(data, i) == find(data, j)


def task(n, delivery_ids, parent_ids, not_delivered_yet_ids):
    parents = [i for i in range(n)]
    for i, parent in enumerate(parent_ids):
        if parent == 0:
            continue
        union(parents, i, parent - 1)

    can_send = [True] * n
    for i, delivery in enumerate(delivery_ids):
        if delivery in not_delivered_yet_ids:
            can_send[find(parents, i)] = False

    answers = []
    for i, send in enumerate(can_send):
        if send and find(parents, i) == i:
            answers.append(i+1)

    return answers


def main():
    args = read_input()
    res = task(*args)
    print(len(res))
    print(" ".join(map(str, res)))


if __name__ == "__main__":
    main()
