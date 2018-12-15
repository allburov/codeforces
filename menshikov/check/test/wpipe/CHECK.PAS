{
Written by Fyodor Menshikov 19.08.2004
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
   begin
      if c='0' then begin
         n:=0;
         nextChar;
      end
      else if c in ['1'..'9'] then begin
         n:=ord(c)-ord('0');
         nextChar;
         while c in ['0'..'9'] do begin
            n:=n*10+ord(c)-ord('0');
            nextChar;
            if n>100 then
               n:=100;
         end;
      end
      else
         pe;
   end;

var
   minus:boolean;
   ua,ja:integer;
begin
   assign(input,'wpipe.out');
   reset(input);
   nextChar;
   if c='-' then begin
      minus:=true;
      nextChar;
   end
   else
      minus:=false;
   number(ua);
   if c<>#13 then
      pe;
   readln;
   if not eof then
      pe;
   if minus and (ua<>1) then
      pe;
   if minus then
      ua:=-ua;
   assign(input,'wpipe.chk');
   reset(input);
   readln(ja);
   if ua<>ja then
      wa;
   ac;
end.