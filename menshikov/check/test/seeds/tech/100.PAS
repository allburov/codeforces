var
   i:integer;
begin
   randomize;
   writeln(100);
   for i:=1 to 100 do
      write(random(10000):5);
   writeln;
   for i:=1 to 100 do{the only distribution is 1% per place}
      write(1:5);
   writeln;
end.