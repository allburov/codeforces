var
   i:integer;
begin
   randomize;
   assign(output,'nosum.i04');
   rewrite(output);
   writeln(200);
   for i:=1 to 100 do
      writeln(i);
   for i:=101 to 200 do
      writeln(int(random*1000000000)+longint(6000):0:0);
end.