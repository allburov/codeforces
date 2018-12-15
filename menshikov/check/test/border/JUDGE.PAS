{
Written by Fyodor Menshikov 01.04.2002
20:44-21:03
}
{$N+,E-}
type
   tpoint=record
      x,y:longint;
   end;

   procedure readPoint(var p:tpoint);
   begin
      readln(p.x,p.y);
   end;

   function gcd(x,y:longint):longint;
   begin
      if y=0 then
         gcd:=x
      else
         gcd:=gcd(y,x mod y);
   end;

   function points_between(p1,p2:tpoint):longint;
   var
      dx,dy:longint;
   begin
      dx:=abs(p1.x-p2.x);
      dy:=abs(p1.y-p2.y);
      if dx=0 then
         points_between:=dy
      else if dy=0 then
         points_between:=dx
      else
         points_between:=gcd(dx,dy);
   end;

var
   n,i:longint;
   first,cur,prev:tpoint;
   sum:comp;
begin
   assign(input,'border.in');
   reset(input);
   readln(n);
   readpoint(first);
   prev:=first;
   sum:=0;
   for i:=2 to n do begin
      readpoint(cur);
      sum:=sum+points_between(cur,prev);
      prev:=cur;
   end;
   sum:=sum+points_between(prev,first);
   close(input);
   assign(output,'border.out');
   rewrite(output);
   writeln(sum:0:0);
   close(output);
end.