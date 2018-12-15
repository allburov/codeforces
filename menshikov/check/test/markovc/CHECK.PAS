{
Written by Fyodor Menshikov 17.08.2004
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
         n:=0;
         nextChar;
      end
      else if c in ['1'..'9'] then begin
         n:=ord(c)-ord('0');
         nextChar;
         while c in ['0'..'9'] do begin
            n:=n*10+ord(c)-ord('0');
            if n>200000000 then
               n:=200000000;
            nextChar;
         end;
      end
      else
         pe;
   end;

var
   cyclic,acyclic,ja,jc:longint;
begin
   assign(input,'markovc.out');
   reset(input);
   nextChar;
   number(acyclic);
   if c<>' ' then
      pe;
   nextChar;
   number(cyclic);
   if c<>#13 then
      pe;
   readln;
   if not eof then
      pe;
   assign(input,'markovc.chk');
   reset(input);
   readln(ja,jc);
   if (acyclic<>ja)or(cyclic<>jc) then
      wa;
   ac;
end.