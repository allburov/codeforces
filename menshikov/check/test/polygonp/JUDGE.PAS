{
Written by Fyodor Menshikov 15.08.2004
21:03-21:13 (+1)
}
{$N+,E-}
type
   integer=longint;
   real=extended;
   point=record
      x,y:integer;
   end;

   procedure readPoint(var p:point);
   begin
      readln(p.x,p.y);
   end;

var
   area,border:real;

   procedure addArea(p1,p2:point);
   begin
      area:=area+(p2.x-p1.x)*(p1.y+p2.y)/2;
   end;

   function gcd(x,y:integer):integer;
   begin
      if y=0 then
         gcd:=x
      else
         gcd:=gcd(y,x mod y);
   end;

   procedure addBorder(p1,p2:point);
   begin
      border:=border+gcd(abs(p2.x-p1.x),abs(p2.y-p1.y));
   end;

var
   first,p1,p2:point;
   i,n:integer;
begin
   assign(input,'polygonp.in');
   reset(input);
   assign(output,'polygonp.out');
   rewrite(output);
   readln(n);
   readPoint(first);
   area:=0;
   border:=0;
   p2:=first;
   for i:=2 to n do begin
      p1:=p2;
      readPoint(p2);
      addArea(p1,p2);
      addBorder(p1,p2);
   end;
   addArea(p2,first);
   addBorder(p2,first);
   area:=abs(area);
   writeln(1+area-border/2:0:0);
end.