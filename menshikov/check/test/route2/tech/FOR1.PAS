const
	n=10;
	k=200;
var
	i,j:integer;
begin
	assign(output,'route2.i01');
	rewrite(output);
	randomize;
	writeln(n,' ',k);
	for i:=1 to n do begin
		for j:=1 to n-1 do
			write(random(99)+1,' ');
		writeln(random(99)+1);
	end;
end.