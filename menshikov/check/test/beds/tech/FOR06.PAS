const
   n=100;
const
   pict:array[1..5,1..5]of char=(
      ('#','#','.','#','#'),
      ('#','.','#','.','#'),
      ('.','#','#','#','.'),
      ('#','.','#','.','#'),
      ('#','#','.','#','#')
   );
var
   a:array[1..n,1..n]of char;
   i,j,cnt,di,dj:integer;
begin
   for i:=1 to n do 
      for j:=1 to n do
         a[i,j]:='#';
   randomize;
   for cnt:=1 to 10 do begin
      i:=random(n-5);
      j:=random(n-5);
      for di:=1 to 5 do
         for dj:=1 to 5 do
            a[i+di,j+dj]:=pict[di,dj];
   end;
   writeln(n,' ',n);
   for i:=1 to n do begin
      for j:=1 to n do
         write(a[i,j]);
      writeln;
   end;
end.