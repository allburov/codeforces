{
Written by Fyodor Menshikov 11.10.2003
5:12-5:43 (+1)
}
{$M 65520,0,0}
var
   a,b:array[-1..102,-1..102]of char;
   w,h:integer;
   bestholey,bestarea:integer;
   i,j:integer;
   mini,minj,maxi,maxj,curarea,curholey:integer;
   ii,jj:integer;

   procedure getCoords;
   begin
      if a[i,j]<>'*' then
         exit;
      a[i,j]:='#';

      if i<mini then
         mini:=i;
      if j<minj then
         minj:=j;
      if i>maxi then
         maxi:=i;
      if j>maxj then
         maxj:=j;
      inc(curarea);

      i:=i+1;
      getCoords;
      i:=i-1;

      i:=i-1;
      getCoords;
      i:=i+1;

      j:=j-1;
      getCoords;
      j:=j+1;

      j:=j+1;
      getCoords;
      j:=j-1;
   end;

   procedure copyToB;
   begin
      if a[i,j]<>'#' then
         exit;
      a[i,j]:='.';
      b[i,j]:='#';

      i:=i+1;
      copyToB;
      i:=i-1;

      i:=i-1;
      copyToB;
      i:=i+1;

      j:=j-1;
      copyToB;
      j:=j+1;

      j:=j+1;
      copyToB;
      j:=j-1;
   end;

   procedure paint;
   begin
      if b[ii,jj]<>'.' then
         exit;
      b[ii,jj]:='#';

      ii:=ii+1;
      paint;
      ii:=ii-1;

      ii:=ii-1;
      paint;
      ii:=ii+1;

      jj:=jj-1;
      paint;
      jj:=jj+1;

      jj:=jj+1;
      paint;
      jj:=jj-1;
   end;

   procedure check;
   begin
      mini:=i;
      minj:=j;
      maxi:=i;
      maxj:=j;
      curarea:=0;
      getCoords;
      for ii:=mini-2 to maxi+2 do
         for jj:=minj-2 to maxj+2 do
            b[ii,jj]:='#';
      for ii:=mini-1 to maxi+1 do
         for jj:=minj-1 to maxj+1 do
            b[ii,jj]:='.';
      {writeln('area ',curarea);}
      copyToB;
      {for ii:=mini-1 to maxi+1 do begin
         for jj:=minj-1 to maxj+1 do
            write(b[ii,jj]);
         writeln;
      end;}
      curholey:=-1;
      for ii:=mini-1 to maxi+1 do
         for jj:=minj-1 to maxj+1 do
            if b[ii,jj]='.' then begin
               paint;
               inc(curholey);
            end;
      {writeln('holeys: ',curholey);}
      if (curholey>bestholey)or(curholey=bestholey)and(curarea<bestarea) then begin
         bestholey:=curholey;
         bestarea:=curarea;
      end;
   end;

begin
   assign(input,'holey.in');
   reset(input);
   assign(output,'holey.out');
   rewrite(output);
   readln(w,h);
   for i:=0 to h+1 do
      for j:=0 to w+1 do
         a[i,j]:='.';
   for i:=1 to h do begin
      for j:=1 to w do
         read(a[i,j]);
      readln;
   end;
   bestholey:=0;
   bestarea:=0;
   for i:=1 to h do
      for j:=1 to w do
         if a[i,j]='*' then
            check;
   writeln(bestarea);
end.