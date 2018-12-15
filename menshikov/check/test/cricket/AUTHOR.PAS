{ SOLUTION for "Cricket Field" problem for NEERC'2002 }
{ (C) Roman Elizarov, 2002 }

{$A+,B-,D+,E+,F-,G-,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}
program CRICKET_SOLUTION;

function min(a, b: integer): integer;
begin
  if a < b then
    min := a
  else
    min := b;
end;

function max(a, b: integer): integer;
begin
  if a > b then
    max := a
  else
    max := b;
end;

const
  MAX_N = 100;
  MAX_COORD = 10000;

var
  n, w, h: integer;
  x, y: array[1..MAX_N] of integer;
  i, j, k: integer;
  bl, bp, bq: integer;
  l, ll, p, q: integer;

begin
  assign(input, 'cricket.in'); reset(input);
  assign(output, 'cricket.out'); rewrite(output);
  { Read }
  read(n, w, h);
  for i := 1 to n do
    read(x[i], y[i]);
  { Solve }
  bl := 0;
  for i := 0 to n do begin
    if i = 0 then
      p := 0
    else
      p := x[i];
    for j := 0 to n do begin
      if j = 0 then
        q := 0
      else
        q := y[j];
      { Try (p,q) placing }
      l := min(w - p, h - q);
      for k := 1 to n do 
        if (x[k] > p) and (y[k] > q) then begin
          ll := max(x[k] - p, y[k] - q);
          if ll < l then
            l := ll;
        end;
      if l > bl then begin
        bl := l;
        bp := p;
        bq := q;
      end;
    end;
  end;
  { Write }
  writeln(bp, ' ', bq, ' ', bl);
end.
