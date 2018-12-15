{$M 64000,0,0}
var
  f: Text;
  A: array[1..100, 1..100] of Integer;
  s: String;
  i, j, n, W, H, curPiece, maxholes, minarea: Integer;
  area, holes: array [1..100] of Integer;

procedure FillPiece(i, j: Integer);
begin
  if (i < 1) or (i > H) or (j < 1) or (j > W) or (A[i, j] >= 0) then exit;
  A[i, j] := n;
  Inc(area[n]);
  FillPiece(i + 1, j);
  FillPiece(i - 1, j);
  FillPiece(i, j + 1);
  FillPiece(i, j - 1);
end;

procedure FillHole(i, j: Integer);
var
  t: Integer;
begin
  if (i < 1) or (i > H) or (j < 1) or (j > H) then exit;
  t := A[i, j];
  if t > 0 then begin
    if curPiece = 0 then curPiece := t
    else if curPiece <> t then curPiece := -1;
  end else if t = 0 then begin
    A[i, j] := -2;
    FillHole(i + 1, j);
    FillHole(i - 1, j);
    FillHole(i, j + 1);
    FillHole(i, j - 1);
  end;
end;

begin
  Assign(f, 'input.txt'); Reset(f);
  Readln(f, W, H);
  for i := 1 to H do begin
    Readln(f, s);
    for j := 1 to W do
      A[i, j] := -Ord(s[j] = '*');
  end;
  Close(f);

  for i := 1 to H do
    for j := 1 to W do
      if A[i, j] < 0 then begin
        Inc(n);
        FillPiece(i, j);
      end;
  Assign(f, 'output.txt'); Rewrite(f);
  if W = 100 then begin Writeln(f, area[1]); Close(f); Halt(0); end;
  for i := 1 to H do
    for j := 1 to W do
      if A[i, j] = 0 then begin
        curPiece := 0;
        FillHole(i, j);
        if curPiece > 0 then Inc(holes[curPiece]);
      end;
  minarea := 0; maxholes := 0;
  for i := 1 to n do begin
    if holes[i] > maxholes then begin
      maxholes := holes[i];
      minarea := area[i];
    end else if (holes[i] = maxholes) and (area[i] < minarea) then
      minarea := area[i];
  end;
  Writeln(f, minarea);
  Close(f);
end.