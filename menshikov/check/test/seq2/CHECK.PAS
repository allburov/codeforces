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
   ch,jCh:char;
begin
   assign(input,'seq2.out');
   reset(input);
   read(ch);
   if not (ch in ['0'..'9']) then
      pe;
   if not eoln then
      pe;
   readln;
   if not eof then
      pe;
   assign(input,'seq2.chk');
   reset(input);
   read(jCh);
   if ch<>jCh then
      wa
   else
      ac;
end.