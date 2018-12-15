{
Written by Fyodor Menshikov 11.10.2003
0:21-0:34
I/O filename changed 12.01.2004
}
{$N+,E-}
type
   integer=longint;
   real=extended;

   function touches(x1,y1,x2,y2,xs,ys,xf,yf:real):boolean;
   var
      a,b,c,r1,r2,r3,r4:real;
      isZ,isP,isN:boolean;
   begin
      {(x-xs)/(xf-xs)=(y-ys)/(yf-ys) <=> (x-xs)*(yf-ys)-(y-ys)*(xf-xs)=0}
      a:=(yf-ys);
      b:=-(xf-xs);
      c:=-xs*(yf-ys)+ys*(xf-xs);
      r1:=a*x1+b*y1+c;
      r2:=a*x1+b*y2+c;
      r3:=a*x2+b*y1+c;
      r4:=a*x2+b*y2+c;
      isZ:=(r1=0)or(r2=0)or(r3=0)or(r4=0);
      isP:=(r1>0)or(r2>0)or(r3>0)or(r4>0);
      isN:=(r1<0)or(r2<0)or(r3<0)or(r4<0);
      touches:=isZ or (isP and isN);
   end;

var
   n,i,j,count:integer;
   w,e:real;
begin
   assign(input,'sqline.in');
   reset(input);
   assign(output,'sqline.out');
   rewrite(output);
   readln(n,w,e);
   count:=0;
   for i:=1 to n do
      for j:=1 to n do
         if touches((i-1)*100.0,(j-1)*100.0,i*100.0,j*100.0,0,w,n*100.0,e) then
            inc(count);
   writeln(count);
end.