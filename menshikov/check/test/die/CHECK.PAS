{
Written by Fyodor Menshikov (Spring 2002)
I/O filename changed 12.01.2005
}
{$N+,E-}
   procedure ac;
   begin
      writeln('a');
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
   judge_answer,user_answer:extended;
begin
   assign(input,'die.out');
   reset(input);
   {$I-}
   read(user_answer);
   {$I+}
   if ioresult<>0 then
      pe;
   if not eoln then
      pe;
   readln;
   if not eof then
      pe;
   assign(input,'die.chk');
   reset(input);
   readln(judge_answer);
   if abs(user_answer-judge_answer)<=0.01*judge_answer then
      ac
   else
      wa;
end.