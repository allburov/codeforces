DECLARE FUNCTION Cross& (x1&, y1&, x2&, y2&)
DEFLNG A-Z
OPEN "input.txt" FOR INPUT AS 1
DIM SHARED N, W, E
CONST k = 100
INPUT #1, N, W, E
xc = 0: yc = (W \ k) * k '!!!
IF yc = N THEN yc = N - 1
count = 1
SELECT CASE -1
  CASE W > E: d = 0
  CASE W < E: d = k
  CASE W = E: xc = N: IF W MOD k = 0 THEN count = N + N ELSE count = N
END SELECT
DO WHILE xc < N * k - k
  c1 = Cross(xc + k, yc, xc + k, yc + k)
  c2 = Cross(xc, yc + d, xc + k, yc + d)
  IF c1 THEN xc = xc + k: count = count + 1
  IF c2 THEN yc = yc + 2 * d - k: count = count + 1
  IF c1 AND c2 THEN count = count + 1
LOOP
PRINT count

FUNCTION Cross (x1, y1, x2, y2)
  s1# = k * N * (y1 - W) - (E - W) * x1
  s2# = k * N * (y2 - W) - (E - W) * x2
  Cross = s1# * s2# <= 0
END FUNCTION

