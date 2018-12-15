{$N+,E-}
type
   real=extended;
const
   n=10000;
var
   i:integer;
   r,fi:real;
begin
   randomize;
   writeln(n);
   for i:=1 to n do begin
      fi:=i/n*2*pi;
      r:=random*500000+500000;
      writeln(r*cos(fi):0:0,' ',r*sin(fi):0:0);
   end;
end.