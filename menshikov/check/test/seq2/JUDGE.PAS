{
Written by Fyodor Menshikov 17.05.2002
12:30-12:43+tests
}
{$N+,E-}
var
   a,b:array[1..4]of integer;
   n:comp;
   p,i:integer;
begin
   assign(input,'seq2.in');
   reset(input);
   readln(a[1],a[2],a[3]);
   readln(n);
   p:=0;
   b:=a;
   repeat
      b[4]:=(b[1]+b[2]+b[3])mod 10;
      b[1]:=b[2];
      b[2]:=b[3];
      b[3]:=b[4];
      inc(p);
   until (b[1]=a[1])and(b[2]=a[2])and(b[3]=a[3]);
   n:=n-int(n/p)*p+p;
   for i:=2 to round(n) do begin
      a[4]:=(a[1]+a[2]+a[3])mod 10;
      a[1]:=a[2];
      a[2]:=a[3];
      a[3]:=a[4];
   end;
   assign(output,'seq2.out');
   rewrite(output);
   writeln(a[1]);
end.