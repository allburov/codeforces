{
Written by Fyodor Menshikov 15.04.2004
20:56-21:14, debugged by 21:22
I/O filename changed 12.01.2005
}
{-$R+,Q+}
type
   number=array[1..50]of byte;

   procedure set0(var n:number);
   var
      i:integer;
   begin
      for i:=low(n) to high(n) do
         n[i]:=0;
   end;

   procedure set1(var n:number);
   begin
      set0(n);
      n[low(n)]:=1;
   end;

   procedure add(var n1,n2:number);
   var
      i,c:integer;
   begin
      c:=0;
      for i:=low(number) to high(number) do begin
         c:=c+n1[i]+n2[i];
         n1[i]:=c mod 10;
         c:=c div 10;
      end;
      if c<>0 then
         halt(1);
   end;

   procedure show(n:number);
   var
      i:integer;
   begin
      i:=high(n);
      while (i>1)and(n[i]=0) do
         dec(i);
      for i:=i downto 1 do
         write(n[i]);
      writeln;
   end;

const
   presscount:array['A'..'Z']of integer=(
      1,2,3,
      1,2,3,
      1,2,3,
      1,2,3,
      1,2,3,
      1,2,3,4,
      1,2,3,
      1,2,3,4
   );
   digit:array['A'..'Z']of integer=(
      2,2,2,
      3,3,3,
      4,4,4,
      5,5,5,
      6,6,6,
      7,7,7,7,
      8,8,8,
      9,9,9,9
   );
   maxpress:array[2..9]of integer=(3,3,3,3,3,4,3,4);
var
   message:string;
   msgbutton:array[-4..320]of integer;
   n,presses,last:integer;
   i,j:integer;
   count:array[-4..0,0..80]of number;
begin
   assign(input,'sms.in');
   reset(input);
   assign(output,'sms.out');
   rewrite(output);
   readln(n);
   readln(message);
   presses:=0;
   for i:=-4 to -1 do
      msgbutton[i]:=0;
   for i:=1 to length(message) do
      for j:=1 to presscount[message[i]] do begin
         inc(presses);
         msgbutton[presses]:=digit[message[i]];
      end;
   for i:=-4 to 0 do
      for j:=0 to 80 do
         set0(count[i,j]);
   set1(count[0,0]);
   {write('presses: ',presses,' - ');
   for i:=1 to presses do
      write(msgbutton[i]);
   writeln;}
   for i:=1 to presses do begin
      for j:=-4 to -1 do
         count[j]:=count[j+1];
      for j:=0 to 80 do
         set0(count[0,j]);
      for last:=1 to maxpress[msgbutton[i]] do begin
         if msgbutton[i-last+1]<>msgbutton[i] then
            break;
         for j:=1 to 80 do
            add(count[0,j],count[-last,j-1]);
      end;
      {writeln('messages consist of ',i,' button presses');
      for j:=0 to 80 do begin
         write('of length ',j,' - ');
         show(count[0,j]);
      end;}
   end;
   show(count[0,n]);
end.