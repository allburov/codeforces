{
Written by Fyodor Menshikov 15.08.2004
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

type
   integer=longint;
var
   ch:char;

   procedure nextChar;
   begin
      if eoln then
         ch:=#13
      else
         read(ch);
   end;

   procedure number(var n:integer);
   begin
      if ch='0' then begin
         n:=0;
         nextChar;
         if ch in ['0'..'9'] then
            pe;
      end
      else if ch in ['1'..'9'] then begin
         n:=ord(ch)-ord('0');
         nextChar;
         while ch in ['0'..'9'] do begin
            n:=n*10+ord(ch)-ord('0');
            if n>100000000 then
               n:=100000000;
            nextChar;
         end;
      end
      else
         pe;
   end;

var
   outSum,outTime,chkSum,chkTime:integer;
begin
   assign(input,'homer.out');
   reset(input);
   nextChar;
   number(outSum);
   if ch<>#13 then begin
      if ch<>' ' then
         pe;
      nextChar;
      number(outTime);
      if ch<>#13 then
         pe;
   end
   else
      outTime:=0;
   readln;
   if not eof then
      pe;
   assign(input,'homer.chk');
   reset(input);
   read(chkSum);
   if not eoln then
      readln(chkTime)
   else
      chkTime:=0;
   if (outSum<>chkSum)or(outTime<>chkTime) then
      wa;
   ac;
end.