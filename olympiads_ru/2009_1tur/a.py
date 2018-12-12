def position(n):
    if n == 1:
        return 1
    if n == 2:
        return 2
    else:
        return (n - 2) * 3


assert position(1) == 1
assert position(2) == 2
assert position(4) == 6
assert position(100) == 294
