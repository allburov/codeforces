{
Written by Fyodor Menshikov 12.01.2004
1:06-1:13,3:10
}
var
   a:array[0..101,0..101]of char;
   m,n:integer;

   procedure paint;
   var
      i,j:integer;
      was:boolean;
   begin
      while true do begin
         was:=false;
         for i:=1 to m do
            for j:=1 to n do
               if (a[i,j]='#')and(
                  (a[i+1,j]='@')or
                  (a[i-1,j]='@')or
                  (a[i,j+1]='@')or
                  (a[i,j-1]='@')) then begin
                  was:=true;
                  a[i,j]:='@';
               end;
         if not was then
            break;
         was:=false;
         for i:=m downto 1 do
            for j:=n downto 1 do
               if (a[i,j]='#')and(
                  (a[i+1,j]='@')or
                  (a[i-1,j]='@')or
                  (a[i,j+1]='@')or
                  (a[i,j-1]='@')) then begin
                  was:=true;
                  a[i,j]:='@';
               end;
         if not was then
            break;
      end;
   end;

var
   i,j,count:integer;
begin
   assign(input,'remsquar.in');
   reset(input);
   assign(output,'remsquar.out');
   rewrite(output);
   readln(m,n);
   for i:=0 to m+1 do
      for j:=0 to n+1 do
         a[i,j]:='.';
   for i:=1 to m do begin
      for j:=1 to n do
         read(a[i,j]);
      readln;
   end;
   count:=0;
   for i:=1 to m do
      for j:=1 to m do
         if a[i,j]='#' then begin
            inc(count);
            a[i,j]:='@';
            paint;
         end;
   writeln(count);
end.