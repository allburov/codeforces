{
Written by Fyodor Menshikov 27.09.2002
23:02-23:13
I/O file name changed 12.01.2004
}
{$R+,Q+}
type
   tnumber=array[1..21]of integer;
   {for 100 of 1s the result is 573_147_844_013_817_084_101}

   procedure set1(var n:tnumber);
   var
      i:integer;
   begin
      for i:=low(n) to high(n) do
         n[i]:=0;
      n[low(n)]:=1;
   end;

   procedure add(var n1:tnumber;n2,n3:tnumber);
   var
      i,c:integer;
   begin
      c:=0;
      for i:=low(n1) to high(n1) do begin
         c:=c+n2[i]+n3[i];
         n1[i]:=c mod 10;
         c:=c div 10;
      end;
      if c<>0 then
         halt(1);
   end;

   procedure print(n:tnumber);
   var
      i:integer;
   begin
      for i:=high(n) downto low(n) do
         if n[i]<>0 then
            break;
      for i:=i downto 1 do
         write(n[i]);
   end;

var
   cur,next,nnext:tnumber;
   num:string;
   i:integer;
begin
   assign(input,'message.in');
   reset(input);
   readln(num);
   set1(next);{one decrypting of 1 (last) digit}
   set1(nnext);{one decrypting of empty string}
   for i:=length(num)-1 downto 1 do begin
      if (num[i]='0')or(num[i]>'3')or(num[i]='3')and(num[i+1]>'3') then
         cur:=next
      else
         add(cur,next,nnext);
      nnext:=next;
      next:=cur;
   end;
   assign(output,'message.out');
   rewrite(output);
   print(next);
end.