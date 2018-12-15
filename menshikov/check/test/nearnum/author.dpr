program a;

{$APPTYPE CONSOLE}

const
  MAX = 1000;

var
  n: integer;
  p: array [1..MAX, 1..MAX] of integer;

function PP(i, j: integer): integer;
begin
  if (i < 1) or (i > n) or (j < 1) or (j > max) then
    Result := 0
  else
    Result := p[i, j];
end;

procedure ProcessRing(i, j, ring, segment: integer; out count, elem: integer);
const
  DI: array [1..4] of integer = (-1, 1, 1, -1);
  DJ: array [1..4] of integer = (1, 1, -1, -1);
var
  c, sti, stj, cnt, e: integer;
begin
  case segment of
    1:
      begin
        sti := i;
        stj := j - ring;
        cnt := ring + 1;
      end;
    2:
      begin
        sti := i - (ring - 1);
        stj := j + 1;
        cnt := ring;
      end;
    3:
      begin
        sti := i + 1;
        stj := j + ring - 1;
        cnt := ring - 1;
      end;
    else
      begin
        sti := i + ring;
        stj := j;
        cnt := ring;
      end;
  end;
  count := 0;
  elem := 0;
  for c := 1 to cnt do begin
    e := PP(sti, stj);
    if e <> 0 then
      elem := e;
    if e <> 0 then
      Inc(count);
    Inc(sti, DI[segment]);
    Inc(stj, DJ[segment]);
  end;
end;

var
  i, j, k, l, dummy: integer;
  d, d1: array [0..2 * (MAX + 1), 1..4] of integer;
  r: array [1..MAX, 1..MAX] of integer;
  s: integer;
begin
  AssignFile(input, 'input.txt'); reset(input);
  AssignFile(output, 'output.txt'); rewrite(output);
  Read(n);
  for i := 1 to n do
    for j := 1 to n do
      Read(p[i, j]);

  Move(p, r, SizeOf(p));
  for i := 1 to n do begin
    for j := 0 to 2 * n + 1 do
      for k := 1 to 4 do
        ProcessRing(i, 1, j, k, d[j, k], dummy);

    for j := 1 to n do begin
      if p[i, j] = 0 then begin
        for k := 1 to 2 * n + 1 do begin
          s := 0;
          for l := 1 to 4 do
            if (d[k, l] = 1) and (s = 0) then
              s := l
            else if (d[k, l] <> 0) then begin
              s := -1;
              Break;
            end;
          if s > 0 then begin
            ProcessRing(i, j, k, s, dummy, r[i, j]);
            Break;
          end;
          if s = -1 then
            Break;
        end;
      end;

      for k := 1 to 2 * n + 1 do begin
        d1[k, 1] := d[k - 1, 1];
        if PP(i - k, j + 1) <> 0 then
          Inc(d1[k, 1]);

        d1[k, 4]:= d[k - 1, 4];
        if PP(i + k, j + 1) <> 0 then
          Inc(d1[k, 4]);
      end;
      if PP(i, j + 1) <> 0 then
        d1[0, 1] := 1
      else
        d1[0, 1] := 0;
      d1[0, 4] := 0;

      for k := 0 to 2 * n do begin
        d1[k, 2]:= d[k + 1, 2];
        if PP(i - k, j + 1) <> 0 then
          Dec(d1[k, 2]);

        d1[k, 3]:= d[k + 1, 3];
        if PP(i + k, j + 1) <> 0 then
          Dec(d1[k, 3]);
      end;
      d1[2 * n + 1, 2] := 0;
      d1[2 * n + 1, 3] := 0;

      Move(d1, d, SizeOf(d1));
    end;
  end;

  for i := 1 to n do begin
    write(r[i, 1]);
    for j := 2 to n do
      write(' ', r[i, j]);
    writeln;
  end;

  CloseFile(output);
  CloseFile(input);
end.
