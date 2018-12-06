from gym_10016.B import dejkstra, parse_in, sum_dist


def test_floyd():
    content = """5 5
1 2
2 3
3 4
5 3
1 5""".splitlines()
    adj_m = parse_in(content=content)
    dist = dejkstra(adj_m)
    answer = sum_dist(dist)
    expect = 16
    assert expect == answer
