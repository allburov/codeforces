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
      if c in ['1'..'9'] then begin
         n:=ord(c)-ord('0');
         nextChar;
         while c in ['0'..'9'] do begin
            n:=n*10+ord(c)-ord('0');
            if n>100000000 then
               n:=100000000;
            nextChar;
         end;
      end
      else
         pe;
   end;

var
   n,ul,up,jl,jp:longint;
begin
   assign(input,'seeds.in');
   reset(input);
   readln(n);
   assign(input,'seeds.out');
   reset(input);
   nextChar;
   number(ul);
   if c<>' ' then
      pe;
   nextChar;
   number(up);
   if c<>#13 then
      pe;
   readln;
   if not eof then
      pe;
   assign(input,'seeds.chk');
   reset(input);
   readln(jl,jp);
   if ul>=n then
      pe;
   if (jl<>ul)or(jp<>up) then
      wa;
   ac;
end.