var
   i:integer;
begin
   randomize;
   writeln(80);
   for i:=1 to 80 do
      write(chr(ord('A')+random(9)));
   writeln;
end.