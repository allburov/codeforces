var
	a,i:longint;
begin
	assign(output,'research.3');
   rewrite(output);
   a:=3956;
   for i:=1 to 200 do begin
   	writeln(a);
      a:=a*a mod 10000;
   end;
end.