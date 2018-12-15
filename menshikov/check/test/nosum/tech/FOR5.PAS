var
	i:integer;
begin
   randomize;
	assign(output,'nosum.i05');
   rewrite(output);
   writeln(10000);
   for i:=1 to 1000 do
   	writeln(random(i)+1);
   for i:=1001 to 10000 do
   	writeln(random(65535)*longint(10)+1);
end.