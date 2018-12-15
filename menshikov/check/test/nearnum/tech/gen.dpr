program g1;

{$APPTYPE CONSOLE}

var
  f: text;
  i, j, c, n, r: integer;
begin
  assign(f, 'input.txt');
  rewrite(f);
  val(paramstr(1), n, c);
  val(paramstr(2), r, c);
  writeln(f, n);
  for i := 1 to n do begin
    for j := 1 to n do begin
      if random(r) = 0 then begin
        if paramstr(3) = 'equal' then
          write(f, 13:8, ' ')
        else
          write(f, random(1000000) + 1:8, ' ')
      end
      else
        write(f, 0:8, ' ');
    end;
    writeln(f);
  end;
  close(f);
end.