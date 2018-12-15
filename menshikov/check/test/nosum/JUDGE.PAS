{
Written by Fyodor Menshikov 31.05.2002
7:06-7:14
}
{$N+,E-}
var
   a:array[1..10000]of longint;

   procedure sort(l,r:integer);
   var
      i,j:integer;
      buf:longint;
      key:longint;
   begin
      key:=a[(l+r)div 2];
      i:=l;
      j:=r;
      repeat
         while a[i]<key do
            inc(i);
         while a[j]>key do
            dec(j);
         if i<=j then begin
            buf:=a[i];
            a[i]:=a[j];
            a[j]:=buf;
            inc(i);
            dec(j);
         end;
      until i>j;
      if l<j then
         sort(l,j);
      if i<r then
         sort(i,r);
   end;
var
   n:integer;
   sum:comp;
begin
   assign(input,'nosum.in');
   reset(input);
   readln(n);
   for n:=1 to n do
      read(a[n]);
   sort(1,n);
   assign(output,'nosum.out');
   rewrite(output);
   sum:=0;
   for n:=1 to n do
      if a[n]>sum+1 then
         break
      else
         sum:=sum+a[n];
   writeln(sum+1:0:0);
end.