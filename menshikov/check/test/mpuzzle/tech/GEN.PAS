var
  f: Text;
  i: Integer;
begin
  Assign(f, 'D00.tst'); Rewrite(f);
  Randomize;
  Writeln(f, 90);
  for i := 1 to 90 do 
    Write(f, Random(60)+20, ' ');
  Close(f);
end.
