type
	integer=longint;
var
	a,b,c,n,i:integer;
   max:integer;
begin
	max:=0;
	assign(output,'research.1');
   rewrite(output);
   for a:=0 to 9999 do begin
   	b:=a;
   	for i:=2 to 10001 do
      	b:=b*b mod 10000;
      c:=b;
      n:=0;
      repeat
      	b:=b*b mod 10000;
         inc(n);
      until b=c;
      writeln(a,' ',n);
      if n>max then
      	max:=n;
   end;
   writeln('max ',max);
end.