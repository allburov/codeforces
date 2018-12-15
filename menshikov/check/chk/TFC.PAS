{
Written by Fyodor Menshikov 07.02.2003
8:19-8:35
}
{$I+}
var
	line,pos:longint;

	procedure a;
	begin
		halt(0);
	end;

	procedure wa;
	begin
		writeln('Difference found in line ',line,' position ',pos);
		halt(1);
	end;

	procedure pe(message:string);
	begin
		writeln('Error: ',message);
		while true do;
	end;

var
	f1,f2:text;
	c1,c2:char;
begin
	if paramcount<>2 then
		pe('not two parameters');
	filemode:=0;
	assign(f1,paramstr(1));
	{$I-}
	reset(f1);
	{$I+}
	if ioresult<>0 then
		pe('cannot open file '+paramstr(1));
	assign(f2,paramstr(2));
	{$I-}
	reset(f2);
	{$I+}
	if ioresult<>0 then
		pe('cannot open file '+paramstr(2));
	line:=1;
	pos:=1;
	while true do begin
		if eof(f1) and eof(f2) then
			a;
		if eoln(f1) and eof(f2) then begin
			readln(f1);
			inc(line);
			pos:=1;
			if not eof(f1) then
				wa;
			a;
		end;
		if eof(f1) and eoln(f2) then begin
			readln(f2);
			inc(line);
			pos:=1;
			if not eof(f2) then
				wa;
			a;
		end;
		if eoln(f1) and eoln(f2) then begin
			readln(f1);
			readln(f2);
			inc(line);
			pos:=1;
			continue;
		end;
		if eoln(f1) and not eoln(f2) then
			wa;
		if not eoln(f1) and eoln(f2) then
			wa;
		if not eoln(f1) and not eoln(f2) then begin
			read(f1,c1);
			read(f2,c2);
			if c1<>c2 then
				wa;
			inc(pos);
			continue;
		end;
		pe('internal');
	end;
end.