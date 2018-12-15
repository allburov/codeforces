{ VERIFICATION PROGRAM for WALL problem for NEERC'2001 }
{ (C) Roman Elizarov }
{$APPTYPE CONSOLE}
program WALL_CHECK;
uses
  sysutils, testlib in '..\testlib.pas';

const
  eps = 1e-5;

var
  iouf, n, l, i, k, t, vx, vy, start: integer;
  len, best, cur: double;
  x, y: array of integer;

begin
  try 
    { Read output }
    iouf := ouf.readInteger;
    if not ouf.seekeof then
      Quit(_PE, 'Extra data in file');
    { Read input & solve problem }
    n := inf.readInteger;
    l := inf.readInteger;
    setLength(x, n + 1);
    setLength(y, n + 1);
    { Read backwards - counter-clocwise orde will result }
    for i := n downto 1 do begin
      x[i] := inf.readInteger;
      y[i] := inf.readInteger;
    end;
    x[0] := x[n];
    y[0] := y[n];
    { Find rightmost & topmost - k }
    k := 1;
    for i := 2 to n do
      if (x[i] > x[k]) or ((x[i] = x[k]) and (y[i] > y[k])) then
        k := i;
    { Init base vector }
    vx := 0;
    vy := 1;
    start := k; { remember initial point }
    len := 2*pi*l; { init length }
    repeat
      { Here: k - last vertex }
      best := -1e30;
      t := 0;
      for i := 1 to n do 
        if i <> k then 
          if vx * (y[i] - y[k]) - vy * (x[i] - x[k]) > -eps then begin { to the left or straigh ahead }
            cur := (vx * (x[i] - x[k]) + vy * (y[i] - y[k]))/sqrt(sqr(x[i] - x[k]) + sqr(y[i] - y[k]));
            if cur > best then begin
              best := cur;
              t := i;
            end;
        end;
      assert(t <> 0);
      { Here: (k, t) - new edge }
      len := len + sqrt(sqr(x[t] - x[k]) + sqr(y[t] - y[k]));
      vx := x[t] - x[k];
      vy := y[t] - y[k];
      k := t;
    until k = start;
    { Check output }
    if abs(iouf - len) > 8/12 then
      Quit(_WA, 'Wrong answer: ' + IntToStr(iouf) + ' too far from ' + FloatToStr(len));
    Quit(_OK, 'Ok');
  except on e: Exception do
    Quit(_Fail, e.Message);
  end;
end.
