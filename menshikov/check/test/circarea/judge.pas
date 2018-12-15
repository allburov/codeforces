{
Written by Fyodor Menshikov (Autumn 2002)
During training
}
{$N+,E-}
type
   real=extended;
var
   x1,y1,r1,x2,y2,r2,x,y,dist,alpha,way2,way1,alpha1,alpha2:real;
   i,succ,border:longint;
const
   max=1000000;
   eps=1e-10;

   function arccos(_cos:real):real;
   var
      _tan:real;
   begin
      _tan:=sqrt(1/sqr(_cos)-1);
      arccos:=arctan(_tan);
   end;

begin
   assign(input,'circarea.in');
   reset(input);
   assign(output,'circarea.out');
   rewrite(output);
   readln(x1,y1,r1,x2,y2,r2);
   x2:=x2-x1;
   y2:=y2-y1;
   x1:=0;
   y1:=0;
   dist:=sqrt(sqr(x2)+sqr(y2));
   if r1>dist+r2-eps then begin
      writeln(pi*r2*r2:0:2);
      {halt(1);}
      exit;
   end;
   if r2>dist+r1-eps then begin
      writeln(pi*r1*r1:0:2);
      {halt(1);}
      exit;
   end;
   if dist>r1+r2-eps then begin
      writeln(0.0:0:2);
      {halt(1);}
      exit;
   end;
   if (r1=0)or(r2=0) then begin
      writeln(0.0:0:2);
      exit;
   end;
   way2:=(sqr(r2)-sqr(r1)+sqr(dist))/2/dist;
   way1:=dist-way2;
   {halt(1);}
   {writeln('~',dist:0:2,' ',way1:0:2,' ',way2:0:2,' ',r1:0:2,' ',r2:0:2);}
   if (way1>0)and(way2>0) then begin
      alpha1:=arccos(way1/r1);
      alpha2:=arccos(way2/r2);
      {writeln('alpha1=',alpha1:0:2,' alpha2=',alpha2:0:2);
      writeln(cos(alpha1),' ',cos(alpha2));
      writeln(way1/r1,' ',way2/r2);}
      writeln(
         (alpha1-sin(alpha1)*cos(alpha1))*r1*r1+
         (alpha2-sin(alpha2)*cos(alpha2))*r2*r2:0:2);
      {halt(1);}
      exit;

   end;
   if way1<0 then begin
      alpha1:=arccos(-way1/r1);
      alpha2:=arccos(way2/r2);
      writeln(
         (pi-alpha1+sin(alpha1)*cos(alpha1))*r1*r1+
         (alpha2-sin(alpha2)*cos(alpha2))*r2*r2:0:2);
      exit;
   end;
   if way2<0 then begin
      alpha1:=arccos(way1/r1);
      alpha2:=arccos(-way2/r2);
      writeln(
         (pi-alpha2+sin(alpha2)*cos(alpha2))*r2*r2+
         (alpha1-sin(alpha1)*cos(alpha1))*r1*r1:0:2);
      exit;
   end;
   if way1=0 then begin
      alpha2:=arccos(way2/r2);
      writeln(
         pi*r1*r1/2+
         (alpha2-sin(alpha2)*cos(alpha2))*r2*r2:0:2);
      exit;
   end;
   if way2=0 then begin
      alpha1:=arccos(way1/r1);
      writeln(
         pi*r2*r2/2+
         (alpha1-sin(alpha1)*cos(alpha2))*r1*r1:0:2);
      exit;
   end;
   halt(1);
end.