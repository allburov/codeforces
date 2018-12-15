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

   procedure number(var n:longint);
   begin
      if c='0' then begin
         nextChar;
         n:=0;
      end
      else if c in ['1'..'9'] then begin
         n:=ord(c)-ord('0');
         nextChar;
         while c in ['0'..'9'] do begin
            n:=n*10+ord(c)-ord('0');
            if n>1000000 then
               n:=1000001;
            nextChar;
         end;
      end
      else
         pe;
   end;

var
   ua,ja:longint;
   minus:boolean;
begin
   assign(input,'sprsheet.out');
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
   if (ua=0) and minus then
      pe;
   if ua>1000000 then
      pe;
   if (ua=1000000) and minus then
      pe;
   assign(input,'sprsheet.out');
   reset(input);
   readln(ja);
   if ua<>ja then
      wa;
   ac;
end.