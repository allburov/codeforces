price_str = """0 -10.00
1 22.00
2 44.00
3 64.33
4 84.67
5 105.00
6 124.00
7 143.00
8 162.00
9 181.00
10 200.00
11 218.00
12 236.00
13 254.00
14 272.00
15 290.00
16 308.00
17 326.00
18 344.00
19 362.00
20 380.00
21 392.13
22 404.25
23 416.38
24 428.50
25 440.63
26 452.75
27 464.88
28 477.00
29 489.13
30 501.25
31 513.38
32 525.50
33 537.63
34 549.75
35 561.88
36 574.00
37 586.13
38 598.25
39 610.38
40 622.50
41 634.63
42 646.75
43 658.88
44 671.00
45 683.13
46 695.25
47 707.38
48 719.50
49 731.63
50 743.75
51 755.88
52 768.00
53 780.13
54 792.25
55 804.38
56 816.50
57 828.63
58 840.75
59 852.88
60 865.00
61 863.50
62 862.00
63 860.50
64 859.00
65 857.50
66 856.00
67 854.50
68 853.00
69 851.50
70 850.00"""
PRICE = {
    int(x): int(y.replace('.', '')) + 1000
    for x, y in (
    z.split() for z in price_str.splitlines()
)}
for i in range(71, 4001):
    PRICE[i] = PRICE[i - 1] + 1571

PRICE_INC = [0]
for i in range(1, len(PRICE)):
    PRICE_INC.append(PRICE[i] - PRICE[i - 1])


def price_min(count):
    for i in range(count, 71):
        if PRICE[count] > PRICE[i]:
            count = i
    return count


def metro(a, b, c):
    a_count = a
    b_count = b
    # Великий перебор
    MAX_C = 2001
    if c > 0 and 2 * c < MAX_C:
        all_answer = [(PRICE[price_min(a_count + i)] + PRICE[price_min(b_count + j)], (i, j))
                      for i in range(MAX_C) for j
                      in range(MAX_C) if
                      i + j == c * 2]
        all_answer.sort()
        tmp_sum, (a_count_inc, b_count_inc) = all_answer[0]
        a_count += a_count_inc
        b_count += b_count_inc

    else:
        for i in range(c * 2):
            if PRICE_INC[a_count + 1] < PRICE_INC[b_count + 1]:
                a_count += 1
            else:
                b_count += 1

    # Лишние поездки
    a_count = price_min(a_count)
    b_count = price_min(b_count)
    summary = PRICE[a_count] + PRICE[b_count]
    return summary / 100


assert metro(0, 500, 500) == 23085.60
assert metro(1, 1, 0) == 64.00
assert metro(0, 0, 70) == 1720.00
assert metro(59, 0, 0) == 860.00
assert metro(10, 10, 10) == 721.25
assert metro(0, 0, 30) == 860
assert metro(1000, 1000, 1000) == 62360.60
# assert metro(58, 58, 3) == 860 + 860
