{
Written by Fyodor Menshikov 20.09.2003
2:19-2:37
}
{$N+,E-}
type
   real=extended;
var
   altitude,bisector,median:real;

   function calcBisector(space:real):real;
   var
      mx:real;
      leftx,rightx:real;
      leftlen,rightlen:real;
      bx:real;
   begin
      mx:=sqrt(sqr(median)-sqr(altitude));
      leftx:=mx+space;
      rightx:=mx-space;
      leftlen:=sqrt(sqr(leftx)+sqr(altitude));
      rightlen:=sqrt(sqr(rightx)+sqr(altitude));
      bx:=rightx+(leftx-rightx)/(leftlen+rightlen)*rightlen;
      calcBisector:=sqrt(sqr(bx)+sqr(altitude));
   end;

var
   r:array[0..3]of real;
   i,j:integer;
   low,high,mid:real;
begin
   assign(input,'tria-abm.in');
   reset(input);
   assign(output,'tria-abm.out');
   rewrite(output);
   readln(r[1],r[2],r[3]);
   for i:=1 to 3 do
      for j:=1 to 3 do
         if (i<j)and(r[i]>r[j]) then begin
            r[0]:=r[i];
            r[i]:=r[j];
            r[j]:=r[0];
         end;
   altitude:=r[1];
   bisector:=r[2];
   median:=r[3];
   if (altitude=bisector)and(bisector=median) then begin
      writeln(0);
      halt;
   end;
   if (altitude=bisector)or(bisector=median) then begin
      writeln(-1);
      halt;
   end;
   low:=sqrt(sqr(median)-sqr(altitude))-sqrt(sqr(bisector)-sqr(altitude));
   high:=low;
   while calcBisector(high)>bisector do
      high:=high*2;
   while true do begin
      mid:=(high+low)/2;
      if (mid=high)or(mid=low) then
         break;
      if calcBisector(mid)>bisector then
         low:=mid
      else
         high:=mid;
   end;
   writeln(mid*altitude:0:4);
end.