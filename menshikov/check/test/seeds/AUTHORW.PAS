
var
  f: Text;
  N, i, ll, pp, ml, mp, me, tl, tr: Longint;
  P, B: array [1..200] of Integer;

procedure Calc (ll, pp: Longint; var sl, sr: Longint);
var
  i: Integer;
  ml, mr: Longint;
begin
  for i := N downto ll do P[i + 1] := P[i];
  P[ll] := pp; sl := 0; sr := 0; ml := 1; mr := N + 1;
  for i := 1 to N + 1 do begin
    if P[i] <= P[ml] then ml := i;
    if P[N + 2 - i] <= P[mr] then mr := N + 2 - i;
    if ml = ll then sl := sl + pp * B[i];
    if mr = ll then sr := sr + pp * B[i];
  end;
  for i := ll to N do P[i] := P[i + 1];
end;

begin
  Assign(f, 'input.txt'); Reset(f);
  Read(f, N);
  for i := 1 to N do Read(f, P[i]);
  for i := 1 to N do Read(f, B[i]);
  Close(f);

  ml := N + 1; mp := 10000; me := 0;
  for ll := 2 to N do begin
    Writeln(ll);
    for pp := 1 to 50 do begin
      Calc(ll, pp, tl, tr);
      if tl + tr > 0 then Write(pp:3, ':', tl + tr:4);
      if tl + tr > me then begin ml := ll; mp := pp; me := tl + tr; end;
    end;
    Writeln;
  end;
  Assign(f, 'output.txt'); Rewrite(f);
  Writeln(f, ml - 1, ' ', mp);
  Close(f);
end.
