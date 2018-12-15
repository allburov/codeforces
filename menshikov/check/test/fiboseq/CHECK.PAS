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
   c:char;

   procedure nextChar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
   end;

   procedure unsigned(var n:longint);
   begin
      if c='0' then begin
         n:=0;
         nextChar;
      end
      else if c in ['1'..'9'] then begin
         n:=ord(c)-ord('0');
         nextChar;
         while c in ['0'..'9'] do begin
            if (n>200000000)or(n=200000000)and(c<>'0') then
               pe;
            n:=n*10+ord(c)-ord('0');
            nextChar;
         end;
      end
      else
         pe;
   end;

var
   minus:boolean;
   n,judge:longint;
begin
   assign(input,'fiboseq.out');
   reset(input);
   nextChar;
   if c='-' then begin
      nextChar;
      minus:=true;
   end
   else
      minus:=false;
   unsigned(n);
   if c<>#13 then
      pe;
   readln;
   if not eof then
      pe;
   if minus and (n=0) then
      pe;
   if minus then
      n:=-n;
   assign(input,'fiboseq.chk');
   reset(input);
   readln(judge);
   if n<>judge then
      wa
   else
      ac;
end.