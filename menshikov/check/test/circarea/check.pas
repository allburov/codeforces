{
Written by Fyodor Menshikov 11.02.2003
8:58-9:15
}
{$N+}
type
   real=extended;

   procedure a;
   begin
      writeln('ac');
      halt(0);
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
   correct_value,user_value:real;
   s:string;
   ec:integer;
begin
   assign(input,'circarea.chk');
   reset(input);
   readln(correct_value);
   assign(input,'circarea.out');
   reset(input);
   read(s);
   if not eoln then
      pe;
   readln;
   if not eof then
      pe;
   if pos(' ',s)<>0 then
      pe;
   if pos('.',s)<>length(s)-2 then
      pe;
   val(s,user_value,ec);
   if ec<>0 then
      pe;
   if abs(user_value-correct_value)>=0.006 then
      wa;
   a;
end.