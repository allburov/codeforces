var
	F:array[1..12]of string;
var
	n:integer;
begin
	F[1]:='A';
	F[2]:='B';
	for n:=3 to 12 do
		F[n]:=F[n-1]+F[n-2];
	assign(output,'1.txt');
	rewrite(output);
	for n:=1 to 12 do
		writeln(n,' ',F[n]);
end.