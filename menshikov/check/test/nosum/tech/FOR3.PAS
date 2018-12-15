var
	i:integer;
begin
   randomize;
	assign(output,'nosum.i03');
   rewrite(output);
   writeln(100);
   writeln(1);
   writeln(1);
   writeln(2);
   writeln(2);
   writeln(7);
   for i:=1 to 95 do
   	writeln(random(100)+15);
end.