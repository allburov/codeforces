var
  x1, y1, x2, y2, k: longint;
  l, c: array [1..4] of longint;

  qx, qy: array [1..4] of longint;
  sumX, sumY: longint;
  total: longint;
  best: longint;

procedure goY(i: longint);
var
  j: longint;
begin
  if total >= best then
    exit;
  if i = k then begin
    if sumY mod l[k] = 0 then begin
      if Abs(sumY) div l[k] <= c[k] - qx[k] then begin
        qy[k] := Abs(sumY) div l[k];
        Inc(total, qy[k]);
        if total < best then
          best := total;
        Dec(total, qy[k]);
      end;
    end;
  end
  else begin
    for j := -(c[i] - qx[i]) to (c[i] - qx[i]) do begin
      Inc(sumY, j * l[i]);
      qy[i] := Abs(j);
      Inc(total, qy[i]);
      goY(i + 1);
      Dec(total, qy[i]);
      Dec(sumY, j * l[i]);
    end;
  end;
end;

procedure goX(i: longint);
var
  j: longint;
begin
  if total >= best then
    exit;
  if i = k then begin
    if sumX mod l[k] = 0 then begin
      if Abs(sumX) div l[k] <= c[k] then begin
        qx[k] := Abs(sumX) div l[k];
        Inc(total, qx[k]);
        sumY := abs(y2 - y1);
        goY(1);
        Dec(total, qx[k]);
      end;
    end;
  end
  else begin
    for j := -c[i] to c[i] do begin
      Inc(sumX, j * l[i]);
      qx[i] := Abs(j);
      Inc(total, qx[i]);
      goX(i + 1);
      Dec(total, qx[i]);
      Dec(sumX, j * l[i]);
    end;
  end;
end;

var
  i: longint;
begin
  assign(input, 'input.txt'); reset(input);
  assign(output, 'output.txt'); rewrite(output);
  read(x1, y1, x2, y2, k);
  for i := 1 to k do
    read(l[i]);
  for i := 1 to k do
    read(c[i]);

  sumX := abs(x2 - x1);
  best := MAXLONGINT;
  goX(1);

  if best <> MAXLONGINT then
    writeln(best)
  else
    writeln(-1);

  close(output);
  close(input);
end.