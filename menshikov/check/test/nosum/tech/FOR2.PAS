var
	i:integer;
begin
   randomize;
	assign(output,'nosum.i02');
   rewrite(output);
   writeln(100);
   writeln(1);
   writeln(1);
   writeln(4);
   for i:=1 to 97 do
   	writeln(random(100)+4);
end.