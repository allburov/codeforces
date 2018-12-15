{
Written by Fyodor Menshikov 19.08.2004
I/O filename changed 12.01.2005
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
   c:char;

   procedure nextChar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
   end;

   procedure number(var n:integer);
   var
      digit:integer;
   begin
      if c='0' then begin
         nextChar;
         n:=0;
      end
      else if c in ['1'..'9'] then begin
         n:=ord(c)-ord('0');
         nextChar;
         while c in ['0'..'9'] do begin
            digit:=ord(c)-ord('0');
            if n<=(9999-digit)div 10 then
               n:=n*10+digit
            else
               pe;
            nextChar;
         end;
      end
      else
         pe;
   end;

var
   ua,ja:integer;
begin
   assign(input,'seq.out');
   reset(input);
   nextChar;
   number(ua);
   if c<>#13 then
      pe;
   readln;
   if not eof then
      pe;
   assign(input,'seq.chk');
   reset(input);
   readln(ja);
   if ua<>ja then
      wa;
   ac;
end.