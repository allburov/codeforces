{$N+,E-}
type
	integer=longint;
	real=extended;
const
	n=50000;
var
	i:integer;
	fi,r:real;
begin
	assign(output,'area.i03');
	rewrite(output);
	writeln(n);
	randomize;
	for i:=1 to n do begin
		fi:=2*pi/n*i;
		r:=random*10000+10000;
		writeln(r*cos(fi):0:0,' ',r*sin(fi):0:0);
	end;
end.