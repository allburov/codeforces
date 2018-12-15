var
	a,i:longint;
begin
	assign(output,'research.2');
   rewrite(output);
   a:=6749;
   for i:=1 to 100 do begin
   	writeln(a);
      a:=a*a mod 10000;
   end;
end.