{
Written by Fyodor Menshikov 29.03.2004
11:57-12:01 (+1) debugged by 12:09
}
   function area2(x1,y1,x2,y2,x3,y3:longint):longint;
   begin
      area2:=abs((x2-x1)*(y3-y1)-(x3-x1)*(y2-y1));
   end;

var
   x,y,xa,ya,xb,yb,xc,yc:longint;
   s,s1,s2,s3:longint;
begin
   assign(input,'tria-pt.in');
   reset(input);
   assign(output,'tria-pt.out');
   rewrite(output);
   readln(xa,ya);
   readln(xb,yb);
   readln(xc,yc);
   readln(x,y);
   s:=area2(xa,ya,xb,yb,xc,yc);
   s1:=area2(x,y,xa,ya,xb,yb);
   s2:=area2(x,y,xb,yb,xc,yc);
   s3:=area2(x,y,xa,ya,xc,yc);
   if s=s1+s2+s3 then
      writeln('In')
   else
      writeln('Out');
end.
