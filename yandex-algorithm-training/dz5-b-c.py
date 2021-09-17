def read_input():
    with open('input.txt') as input_:
        N, M = map(int, input_.readline().split())
        groups = list(map(int, input_.readline().split()))
        flats = list(map(int, input_.readline().split()))
    return N, M, groups, flats


def task(N, M, groupsArray, flatsArray):
    N = len(groupsArray)
    M = len(flatsArray)
    schedule = [0] * len(groupsArray)
    groups = [(group, i) for i, group in enumerate(groupsArray)]
    groups.sort(reverse=True)
    flats = [(flat, i) for i, flat in enumerate(flatsArray)]
    flats.sort(reverse=True)

    i, j = 0, 0
    while j < M and i < N:
        group = groups[i]
        flat = flats[j]
        if group[0] + 1 <= flat[0]:
            g = group[1]
            f = flat[1]
            schedule[g] = f + 1
            j += 1
            i += 1
        else:
            i += 1
    P = len(list(filter(lambda x: x != 0, schedule)))
    return P, schedule



if __name__ == "__main__":
    args = read_input()
    P, schedule = task(*args)
    print(P)
    print(" ".join(map(str, schedule)))
