DECLARE SUB Calc (ll%, pp%, sl%, sr%)
DEFINT A-Z
DIM SHARED P(100), B(100), N
OPEN "input.txt" FOR INPUT AS 1
INPUT #1, N
FOR i = 1 TO N: INPUT #1, P(i): NEXT
FOR i = 1 TO N: INPUT #1, B(i): NEXT
CLOSE 1
OPEN "output.txt" FOR OUTPUT AS 1
ml = N + 1: mp = 10000: me = 0
FOR ll = 1 TO N - 1
  PRINT ll
  FOR pp = 30 TO 50
    Calc ll, pp, tl, tr
    IF tl + tr > 0 THEN PRINT USING "###:##### "; pp; tl + tr;
    IF tl + tr > me THEN ml = ll: mp = pp: me = tl + tr
  NEXT
  PRINT
NEXT
PRINT #1, ml; mp
CLOSE 1

SUB Calc (ll, pp, sl, sr)
  FOR i = N TO ll STEP -1: P(i + 1) = P(i): NEXT
  P(ll) = pp: sl = 0: sr = 0: ml = 1: mr = N + 1
  FOR i = 1 TO N + 1
    IF P(i) <= P(ml) THEN ml = i
    IF P(N + 2 - i) <= P(mr) THEN mr = N + 2 - i
    IF ml = ll THEN sl = sl + pp * B(i)
    IF mr = ll THEN sr = sr + pp * B(i)
  NEXT
  FOR i = ll TO N: P(i) = P(i + 1): NEXT
END SUB

'SYSTEM