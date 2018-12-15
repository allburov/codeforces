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

   procedure number;
   var
      n:longint;
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
            if n>1000000 then
               pe;
         end;
      end
      else
         pe;
   end;

   procedure space;
   begin
      while c=#32 do
         nextChar;
   end;

var
   jf:text;
   n,ua,ja,line,column:longint;
begin
   assign(input,'nearnum.in');
   reset(input);
   readln(n);
   assign(input,'nearnum.out');
   reset(input);
   for line:=1 to n do begin
      nextChar;
      for column:=1 to n do begin
         space;
         number;
      end;
      space;
      if c<>#13 then
         pe;
      readln;
   end;
   if not eof then
      pe;
   reset(input);
   assign(jf,'nearnum.chk');
   reset(jf);
   for line:=1 to n do begin
      for column:=1 to n do begin
         read(ua);
         read(jf,ja);
         if ua<>ja then
            wa;
      end;
   end;
   ac;
end.