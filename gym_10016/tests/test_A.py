from gym_10016.A import floyd


def test_floyd():
    adj_m = [
        [0, 5, 9, 100],
        [100, 0, 2, 8],
        [100, 100, 0, 7],
        [4, 100, 100, 0]
    ]
    answer = floyd(adj_m)
    expect = [
        [0, 5, 7, 13],
        [12, 0, 2, 8],
        [11, 16, 0, 7],
        [4, 9, 11, 0],
    ]
    assert expect == answer


def test_floyd_2():
    adj_m = [
        [0, 4, 2],
        [100, 0, -3],
        [1, -100, 0],
    ]
    answer = floyd(adj_m)
    expect = [
        [0, -98, 1],
        [-2, 0, -3],
        [0, -100, 0],
    ]
    assert expect == answer
