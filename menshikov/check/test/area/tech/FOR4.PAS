{$N+,E-}
type
   integer=longint;
   real=extended;
const
   n=100;
var
   i:integer;
   fi,r:real;
begin
   writeln(n);
   randomize;
   for i:=1 to n do begin
      fi:=2*pi/n*i;
      r:=random*50+50;
      writeln(r*cos(fi):0:0,' ',r*sin(fi):0:0);
   end;
end.