{$R+,Q+}
const
   max=30;
var
   x,y,dx,dy:longint;
begin
   x:=10;
   y:=10;
   writeln(((2+(max+1))*max div 2)*4);
   for dx:=1 to max do
      for dy:=0 to dx do begin
         x:=x+dx;
         y:=y+dy;
         writeln(x,' ',y);
      end;
   for dy:=1 to max do
      for dx:=0 to dy do begin
         x:=x-dx;
         y:=y+dy;
         writeln(x,' ',y);
      end;
   for dx:=1 to max do
      for dy:=0 to dx do begin
         x:=x-dx;
         y:=y-dy;
         writeln(x,' ',y);
      end;
   for dy:=1 to max do
      for dx:=0 to dy do begin
         x:=x+dx;
         y:=y-dy;
         writeln(x,' ',y);
      end;
end.