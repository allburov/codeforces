{
Written by Fyodor Menshikov 22.08.2004
9:46-10:06
}
{$N+,E-}
type
   real=extended;
var
   n:integer;
   x,y:array[1..1000]of longint;

   function hull:real;
   var
      len,sum:real;
      i,start,current,next:integer;
      dx,dy,dx1,dy1,cos,maxcos:real;
   begin
      start:=1;
      for i:=2 to n do
         if (y[i]<y[start])or(y[i]=y[start])and(x[i]<x[start]) then
            start:=i;
      dx:=-1;
      dy:=0;
      current:=start;
      sum:=0;
      repeat
         maxcos:=-2;
         for i:=1 to n do begin
            dx1:=x[i]-x[current];
            dy1:=y[i]-y[current];
            len:=sqrt(dx1*dx1+dy1*dy1);
            if len=0 then
               continue;
            cos:=(dx1*dx+dy1*dy)/len;
            if cos>maxcos then begin
               next:=i;
               maxcos:=cos;
            end;
         end;
         if maxcos=-2 then
            halt(1);
         dx:=x[next]-x[current];
         dy:=y[next]-y[current];
         len:=sqrt(dx*dx+dy*dy);
         sum:=sum+len;
         dx:=dx/len;
         dy:=dy/len;
         current:=next;
      until current=start;
      hull:=sum;
   end;

var
   i,l:integer;
begin
   assign(input,'wall.in');
   reset(input);
   assign(output,'wall.out');
   rewrite(output);
   readln(n,l);
   for i:=1 to n do
      readln(x[i],y[i]);
   writeln(2*pi*l+hull:0:0);
end.