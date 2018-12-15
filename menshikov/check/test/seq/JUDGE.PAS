{
Written by Fyodor Menshikov 06.05.2002
11:05-11:14
I/O filename changed 12.01.2005
}
type
   integer=longint;

   procedure short(a,n:integer);
   begin
      assign(output,'seq.out');
      rewrite(output);
      while n>1 do begin
         a:=a*a mod 10000;
         n:=n-1;
      end;
      writeln(a);
      halt;
   end;

var
   a,n,b,i:integer;
begin
   assign(input,'seq.in');
   reset(input);
   readln(a,n);
   if n<20000 then
      short(a,n);
   for i:=2 to 10001 do
      a:=a*a mod 10000;
   n:=n-10000;
   b:=a;
   i:=0;
   repeat
      a:=a*a mod 10000;
      i:=i+1;
   until a=b;
   n:=i+n mod i;
   short(a,n);
end.
