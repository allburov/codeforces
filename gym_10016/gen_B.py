N = 400
with open("sumdist.in", "w") as f:
    f.write('{} {}\n'.format(N, N))
    for i in range(1, N+1):
        for j in range(1, N+1):
            if i == j: continue
            f.write("{} {}\n".format(i, j))
