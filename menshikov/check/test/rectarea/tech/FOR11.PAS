var
   i:integer;
begin
   randomize;
   writeln(100);
   for i:=1 to 100 do
      writeln(i*2,' ',i*3,' ',i*2+1,' ',i*3+1);
end.