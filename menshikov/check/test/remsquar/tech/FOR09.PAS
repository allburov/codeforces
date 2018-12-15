{$R+,Q+}
const
   rows=16;
   cols=16;
   m=rows*6+1;
   n=cols*6+3;
type
   tpattern=array[1..7]of string[6];
const
   pattern:tpattern=(
      '......',
      '#####.',
      '#...#.',
      '#.###.',
      '#.#...',
      '#.####',
      '......'
   );
var
   i,j,row,col:integer;
   a:array[1..m,1..n]of char;
begin
   for i:=1 to m do
      for j:=1 to n do
         a[i,j]:='.';
   for row:=0 to rows-1 do
      for col:=0 to cols-1 do
         for i:=1 to 6 do
            for j:=1 to 6 do
               if odd(row) then
                  a[row*6+i,col*6+j+1]:=pattern[i,j]
               else
                  a[row*6+i,col*6+j+1]:=pattern[8-i,j];
   for i:=2 to m-1 do
      if i mod 12=1 then
         a[i,2]:='#'
      else
         a[i,n-1]:='#';
   writeln(m,' ',n);
   for i:=1 to m do begin
      for j:=1 to n do
         write(a[i,j]);
      writeln;
   end;
end.