from gym_10016.C import answer_func, parse_in


def test_default():
    content = """2 2
1 2 5
1 2 -5
""".splitlines()
    adj_m = parse_in(content=content)
    dist = answer_func(adj_m)
    expect = 5
    assert expect == dist


def test_plus():
    content = """5 5 
1 5 4
1 2 2
2 3 1
1 3 1
3 5 6
5 4 10
""".splitlines()
    adj_m = parse_in(content=content)
    dist = answer_func(adj_m)
    expect = 9
    assert expect == dist


def test_minus():
    content = """5 5 
1 5 -4
1 2 -2
2 3 -1
1 3 -1
3 5 -6
5 4 -10
""".splitlines()
    adj_m = parse_in(content=content)
    dist = answer_func(adj_m)
    expect = -4
    assert expect == dist


def test_cycle():
    content = """5 5 
1 5 4
1 2 2
2 3 1
1 3 1
3 5 6
1 1 1
5 4 10
""".splitlines()
    adj_m = parse_in(content=content)
    dist = answer_func(adj_m)
    expect = ":)"
    assert expect == dist


def test_cycle_minus():
    content = """5 5 
1 5 4
1 2 2
2 3 1
1 3 1
3 5 6
1 1 -1
5 4 10
""".splitlines()
    adj_m = parse_in(content=content)
    dist = answer_func(adj_m)
    expect = 9
    assert expect == dist


def test_bad():
    content = """5 5 
1 2 2
2 3 1
1 3 1
1 1 -1
5 4 10
""".splitlines()
    adj_m = parse_in(content=content)
    dist = answer_func(adj_m)
    expect = ":("
    assert expect == dist
