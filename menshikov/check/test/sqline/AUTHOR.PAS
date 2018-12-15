{$N+}

const
  s = 100;

var
  f: Text;
  i, j, N, W, E, count: Longint;

function Cross(x1, y1, x2, y2: Longint): Boolean;
var
  s1, s2, t: Extended;
begin
  x1 := x1 * s; y1 := y1 * s;
  x2 := x2 * s; y2 := y2 * s;
  t := N * s;
  s1 := t * (y1 - W) - (E - W) * x1;
  s2 := t * (y2 - W) - (E - W) * x2;
  Cross := s1 * s2 <= 0
end;

begin
  Assign(f, 'input.txt'); Reset(f);
  Read(f, N, W, E);
  Close(f);
  for i := 0 to N - 1 do
    for j := 0 to N - 1 do
      if Cross(i, j, i + 1, j) or Cross(i + 1, j, i + 1, j + 1) or
         Cross(i, j, i, j + 1) or Cross(i + 1, j + 1, i, j + 1)
      then
        Inc(count);
  Assign(f, 'output.txt'); Rewrite(f);
  Writeln(f, count);
  Close(f);
end.