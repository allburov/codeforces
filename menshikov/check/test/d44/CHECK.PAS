{
Written by Fyodor Menshikov 16.08.2004
}
   procedure ac;
   begin
      writeln('a');
      halt;
   end;

   procedure wa;
   begin
      writeln('wa');
      halt(1);
   end;

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

var
   ch:char;

   procedure nextChar;
   begin
      if eoln then
         ch:=#13
      else
         read(ch);
   end;

   procedure number(var n:longint);
   begin
      if ch='0' then begin
         nextChar;
         n:=0;
      end
      else if ch in ['1'..'9'] then begin
         n:=ord(ch)-ord('0');
         nextChar;
         while ch in ['0'..'9'] do begin
            n:=n*10+ord(ch)-ord('0');
            nextChar;
            if n>1000000 then
               n:=1000000;
         end;
      end
      else
         pe;
   end;

var
   outNum,chkNum:longint;
begin
   assign(input,'d44.out');
   reset(input);
   nextChar;
   number(outNum);
   if ch<>#13 then
      pe;
   readln;
   if not eof then
      pe;
   assign(input,'d44.chk');
   reset(input);
   readln(chkNum);
   if abs(outNum-chkNum)<=10 then
      ac
   else
      wa;
end.