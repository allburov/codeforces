{
Written by Fyodor Menshikov 26.01.2004
15:31-15:41,debugged by 16:23
}
{$N+,E-}
type
   real=extended;
var
   r,lat1,lat2,long1,long2,x1,x2,y1,y2,z1,z2,dist,angle:real;
begin
   assign(input,'spherarc.in');
   reset(input);
   assign(output,'spherarc.out');
   rewrite(output);
   readln(r);
   readln(lat1,long1);
   readln(lat2,long2);
   lat1:=lat1/180*pi;
   lat2:=lat2/180*pi;
   long1:=long1/180*pi;
   long2:=long2/180*pi;
   x1:=r*cos(lat1)*cos(long1);
   y1:=r*cos(lat1)*sin(long1);
   z1:=r*sin(lat1);
   x2:=r*cos(lat2)*cos(long2);
   y2:=r*cos(lat2)*sin(long2);
   z2:=r*sin(lat2);
   dist:=sqrt(sqr(x1-x2)+sqr(y1-y2)+sqr(z1-z2));
   if dist>2*r then
      dist:=2*r;
   if dist=2*r then
      angle:=pi
   else
      angle:=2*arctan(dist/2/sqrt(r*r-sqr(dist/2)));
   writeln(r*angle:0:2);
end.