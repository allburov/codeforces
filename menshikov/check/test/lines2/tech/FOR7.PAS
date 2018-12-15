const
	n=249;
var
	a:array[1..n,1..n]of char;
	i,j:integer;
begin
	if n mod 20<>9 then
		halt;
	for i:=1 to n do
		for j:=1 to n do
			a[i,j]:='.';
	for i:=1 to n div 20 do begin
		for j:=1 to n-10 do
			a[i*20-10,j]:='O';
		for j:=11 to n do
			a[i*20,j]:='O';
	end;
	randomize;
	for i:=1 to n do
		for j:=1 to n do
			if random(8)=0 then
				a[i,j]:='O';
	a[1,1]:='@';
	a[n,n]:='X';
	assign(output,'lines2.i07');
	rewrite(output);
	writeln(n);
	for i:=1 to n do begin
		for j:=1 to n do
			write(a[i,j]);
		writeln;
	end;
end.