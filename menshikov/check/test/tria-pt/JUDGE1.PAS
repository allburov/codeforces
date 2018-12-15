{
Written by Fyodor Menshikov 14.03.2002
22:34-22:48
I/O file name changed 17.11.2003
}
type
   tpoint=record
      x,y:longint;
   end;
   tline=record
      a,b,c:longint;
   end;

   procedure getLine(p1,p2:tpoint;var l:tline);
   begin
      l.a:=p2.y-p1.y;
      l.b:=p1.x-p2.x;
      l.c:=p1.y*(p2.x-p1.x)-p1.x*(p2.y-p1.y);
   end;

   function lineValue(l:tline;p:tpoint):longint;
   begin
      lineValue:=l.a*p.x+l.b*p.y+l.c;
   end;

   function equalSign(x,y:longint):boolean;
   begin
      if (x=0)or(y=0) then
         equalSign:=true
      else if (x>0)and(y>0) then
         equalSign:=true
      else if (x<0)and(y<0) then
         equalSign:=true
      else
         equalSign:=false;
   end;

   procedure readPoint(var p:tpoint);
   begin
      readln(p.x,p.y);
   end;

var
   t1,t2,t3:tpoint;
   p:tpoint;
   l1,l2,l3:tline;
   side1,side2,side3:boolean;
begin
   assign(input,'tria-pt.in');
   reset(input);
   readPoint(t1);
   readPoint(t2);
   readPoint(t3);
   readPoint(p);
   close(input);
   getLine(t1,t2,l3);
   getLine(t1,t3,l2);
   getLine(t2,t3,l1);
   side1:=equalSign(lineValue(l1,t1),lineValue(l1,p));
   side2:=equalSign(lineValue(l2,t2),lineValue(l2,p));
   side3:=equalSign(lineValue(l3,t3),lineValue(l3,p));
   assign(output,'tria-pt.out');
   rewrite(output);
   if side1 and side2 and side3 then
      writeln('In')
   else
      writeln('Out');
   close(output);
end.
