var
	i:integer;
begin
	randomize;
	assign(output,'nosum.i01');
   rewrite(output);
   writeln(100);
   for i:=1 to 100 do
   	writeln(random(100)+2);
end.