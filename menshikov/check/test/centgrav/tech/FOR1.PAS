const
	n=100000;
var
	i:longint;
   fi:real;
   r:real;
begin
   assign(output,'centgrav.i03');
   rewrite(output);
   randomize;
   writeln(n);
	for i:=0 to n-1 do begin
   	fi:=2*pi/n*i;
      r:=random;
      writeln(round(r*20000*cos(fi)),' ',round(r*20000*sin(fi)));
   end;
   close(output);
end.