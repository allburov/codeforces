var
   i:integer;
begin
   randomize;
   writeln(75);
   for i:=1 to 80 do
      write(chr(ord('A')+random(26)));
   writeln;
end.