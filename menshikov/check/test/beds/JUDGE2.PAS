{
Written by Fyodor Menshikov 26.01.2004
14:46-14:55
}
{$R+,Q+}
var
   c:array[0..201,0..201]of char;
type
   arr=array[1..40000]of byte;
var
   first,last:word;
   ii,jj:^arr;

   procedure put(i,j:integer);
   begin
      if c[i,j]='#' then begin
         inc(last);
         ii^[last]:=i;
         jj^[last]:=j;
         c[i,j]:='.';
      end;
   end;

   procedure get(var i,j:integer);
   begin
      i:=ii^[first];
      j:=jj^[first];
      inc(first);
   end;

   procedure paint(i,j:integer);
   begin
      first:=1;
      last:=0;
      put(i,j);
      while first<=last do begin
         get(i,j);
         put(i+1,j);
         put(i-1,j);
         put(i,j+1);
         put(i,j-1);
      end;
   end;

var
   n,m,i,j,count:integer;
begin
   new(ii);
   new(jj);
   assign(input,'beds.in');
   reset(input);
   assign(output,'beds.out');
   rewrite(output);
   readln(n,m);
   for i:=0 to n+1 do
      for j:=0 to m+1 do
         c[i,j]:='.';
   for i:=1 to n do begin
      for j:=1 to m do
         read(c[i,j]);
      readln;
   end;
   count:=0;
   for i:=1 to n do
      for j:=1 to m do
         if c[i,j]='#' then begin
            paint(i,j);
            inc(count);
         end;
   writeln(count);
end.