{
Written by Fyodor Menshikov 19.08.2004
}
{$N+,E-}

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

   procedure ie;
   begin
      while true do;
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

   procedure number(var n:comp);
   begin
      if c in ['1'..'9'] then begin
         n:=ord(c)-ord('0');
         nextChar;
         while c in ['0'..'9'] do begin
            n:=n*10+ord(c)-ord('0');
            nextChar;
            if n>1e17 then
               n:=1e17;
         end;
      end
      else
         pe;
   end;

var
   s:string;
   ua,ja:comp;
begin
   assign(input,'train-ab.out');
   reset(input);
   readln(s);
   if s='NO' then begin
      if not eof then
         pe;
      ua:=0;
   end
   else if s='YES' then begin
      if eoln then
         pe;
      nextChar;
      number(ua);
      if c<>#13 then
         pe;
      readln;
      if not eof then
         pe;
   end
   else
      pe;
   assign(input,'train-ab.chk');
   reset(input);
   readln(s);
   if s='NO' then begin
      if ua=0 then
         ac
      else
         wa;
   end
   else if s='YES' then begin
      if ua=0 then
         wa;
      readln(ja);
      if ja<>ua then
         wa
      else
         ac;
   end
   else
      ie;
end.