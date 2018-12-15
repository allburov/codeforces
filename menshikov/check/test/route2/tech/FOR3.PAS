const
	n=100;
	k=2000;
var
	i,j:integer;
begin
	assign(output,'route2.i03');
	rewrite(output);
	randomize;
	writeln(n,' ',k);
	for i:=1 to n do begin
		for j:=1 to n-1 do
			write(random(9999)+1,' ');
		writeln(random(9999)+1);
	end;
end.