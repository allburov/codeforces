{
Written by Fyodor Menshikov 31.05.2002
7:14-7:25
I/O filename changed 03.04.2004
I/O filename changed 12.01.2005
}
{$N+,E-,R-}
type
   real=extended;
var
   prev,cur:array[-6..3000]of real;
   i:integer;
   n,q:integer;
begin
   assign(input,'die.in');
   reset(input);
   readln(n,q);
   for i:=low(cur) to high(cur) do
      cur[i]:=0;
   cur[0]:=1;
   for n:=1 to n do begin
      prev:=cur;
      for i:=low(cur) to high(cur) do
         cur[i]:=0;
      for i:=n to n*6 do
         cur[i]:=(prev[i-1]+prev[i-2]+prev[i-3]+prev[i-4]+prev[i-5]+prev[i-6])/6;
   end;
   assign(output,'die.out');
   rewrite(output);
   writeln(cur[q]);
end.