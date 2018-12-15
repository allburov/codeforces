{
Written by Fyodor Menshikov 19.08.2004
20:19-20:38
}
var
   sx,sy:array[0..100]of boolean;
   s:array[0..10000]of boolean;
   x1,y1,x2,y2,dx,dy,i,j,d,count:integer;
begin
   assign(input,'dlattice.in');
   reset(input);
   assign(output,'dlattice.out');
   rewrite(output);
   readln(x1,y1,x2,y2,dx,dy);
   for i:=0 to 100 do
      sx[i]:=false;
   d:=dx;
   for i:=1 to x1 do begin
      if d+x2<=x1 then
         sx[x2]:=true
      else if (x1<d+x2)and(d+x2<2*x1) then begin
         sx[x1-d]:=true;
         sx[d+x2-x1]:=true;
      end
      else if (d+x2>=2*x1) then begin
         sx[x1-d]:=true;
         sx[x1]:=true;
         sx[(d+x2)mod x1]:=true;
      end
      else
         halt(1);
      d:=(d+x2) mod x1;
   end;
   for i:=0 to 100 do
      sy[i]:=false;
   d:=dy;
   for i:=1 to y1 do begin
      if d+y2<=y1 then
         sy[y2]:=true
      else if (y1<d+y2)and(d+y2<2*y1) then begin
         sy[y1-d]:=true;
         sy[d+y2-y1]:=true;
      end
      else if (d+y2>=2*y1) then begin
         sy[y1-d]:=true;
         sy[y1]:=true;
         sy[(d+y2)mod y1]:=true;
      end
      else
         halt(1);
      d:=(d+y2) mod y1;
   end;
   for i:=0 to 10000 do
      s[i]:=false;
   for i:=1 to 100 do
      for j:=1 to 100 do
         if sx[i] and sy[j] then
            s[i*j]:=true;
   count:=0;
   for i:=1 to 10000 do
      if s[i] then
         inc(count);
   writeln(count);
   for i:=1 to 10000 do
      if s[i] then
         writeln(i);
end.