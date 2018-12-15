
var
  f: Text;
  A: array [1..100] of Longint;
  C: array [1..100, 1..100] of Longint;
  i, j, k, d, N: Integer;
  t, mint: Longint;
begin
  Assign(f, 'input.txt'); Reset(f);
  Read(f, N);
  for i := 1 to N do Read(f, A[i]);
  Close(f);
  for i := 1 to N - 1 do C[i, i + 1] := 0;
  for d := 2 to N - 1 do begin
    for i := 1 to N - d do begin
      j := i + d;
      mint := MaxLongint;
      for k := i + 1 to j - 1 do begin
        t := C[i, k] + C[k, j] + A[i] * A[k] * A[j];
        if t < mint then mint := t;
      end;
      C[i, j] := mint;
    end;
  end;
  Assign(f, 'output.txt'); Rewrite(f);
  Writeln(f, C[1, N]);
  Close(f);
end.
