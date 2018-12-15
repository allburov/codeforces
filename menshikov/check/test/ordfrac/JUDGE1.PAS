{
Written by Fyodor Menshikov 11.01.2004
22:21-22:28
}
{$N+,E-}
type
   real=extended;
var
   a:array[0..30000]of record
      num,den:byte;
   end;

   function gcd(n1,n2:integer):integer;
   begin
      if n2=0 then
         gcd:=n1
      else
         gcd:=gcd(n2,n1 mod n2);
   end;

   procedure sort(l,r:integer);
   var
      key:real;
      i,j,mid:integer;
   begin
      mid:=(l+r)div 2;
      key:=a[mid].num/a[mid].den;
      i:=l;
      j:=r;
      repeat
         while a[i].num/a[i].den<key do
            inc(i);
         while key<a[j].num/a[j].den do
            dec(j);
         if i<=j then begin
            a[0]:=a[i];
            a[i]:=a[j];
            a[j]:=a[0];
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
   n,count,num,den,i:integer;
begin
   assign(input,'ordfrac.in');
   reset(input);
   assign(output,'ordfrac.out');
   rewrite(output);
   readln(n);
   count:=0;
   for den:=2 to n do
      for num:=1 to den-1 do
         if gcd(num,den)=1 then begin
            inc(count);
            a[count].num:=num;
            a[count].den:=den;
         end;
   sort(1,count);
   for i:=1 to count do
      writeln(a[i].num,'/',a[i].den);
end.