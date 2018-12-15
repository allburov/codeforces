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

   procedure pe(id:integer);
   begin
      writeln('pe',id);
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

   procedure number(var n:integer);
   begin
      nextChar;
      if not (ch in ['1'..'9']) then
         pe(1);
      n:=ord(ch)-ord('0');
      nextChar;
      while ch in ['0'..'9'] do begin
         if (n>1000)or(n=1000)and(ch<>'0') then
            pe(2);
         n:=n*10+ord(ch)-ord('0');
         nextChar;
      end;
      if ch<>#13 then
         pe(3);
      readln;
   end;

var
   cnt,i,a,j,prev:integer;
   jf:text;
begin
   assign(input,'dlattice.out');
   reset(input);
   number(cnt);
   prev:=0;
   for i:=1 to cnt do begin
      number(a);
      if a<=prev then
         pe(10);
      prev:=a;
   end;
   if not eof then
      pe(4);
   reset(input);
   assign(jf,'dlattice.chk');
   reset(jf);
   readln(cnt);
   readln(jf,j);
   if cnt<>j then
      wa;
   for i:=1 to cnt do begin
      readln(a);
      readln(jf,j);
      if a<>j then
         wa;
   end;
   ac;
end.