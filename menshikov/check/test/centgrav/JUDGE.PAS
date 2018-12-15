{
Written by Fyodor Menshikov 08.04.2002
21:18-21:30
}
{$N+,E-}
type
   tpoint=record
      x,y:longint;
   end;

   procedure readpoint(var p:tpoint);
   begin
      readln(p.x,p.y);
   end;

var
   n,i:longint;
   p1,p2,p3:tpoint;
   sumwx,sumwy,sumarea:extended;

   procedure count;
   var
      area:extended;
   begin
      area:=0.0+(p2.x-p1.x)*(p3.y-p1.y)-(p3.x-p1.x)*(p2.y-p1.y);
      sumarea:=sumarea+area;
      sumwx:=sumwx+area*(p1.x+p2.x+p3.x);
      sumwy:=sumwy+area*(p1.y+p2.y+p3.y);
   end;

begin
   sumarea:=0;
   sumwx:=0;
   sumwy:=0;
   assign(input,'centgrav.in');
   reset(input);
   readln(n);
   readpoint(p1);
   readpoint(p2);
   for i:=3 to n do begin
      readpoint(p3);
      count;
      p2:=p3;
   end;
   close(input);
   assign(output,'centgrav.out');
   rewrite(output);
   writeln(sumwx/sumarea/3:0:2,' ',sumwy/sumarea/3:0:2);
   close(output);
end.