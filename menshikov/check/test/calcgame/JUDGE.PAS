{
Written by Fyodor Menshikov 22.05.2002
9:37-9:45
}
var
   k,digit,count,module,answer_digit,answer_count:integer;
begin
   assign(input,'calcgame.in');
   reset(input);
   readln(k);
   answer_count:=10000;
   for digit:=1 to 9 do begin
      module:=0;
      for count:=1 to 1000 do begin
         module:=(module*10+digit)mod k;
         if module=0 then begin
            {digits grow, it's not necessary to check count=,digit<}
            if count<answer_count then begin
               answer_digit:=digit;
               answer_count:=count;
            end;
         end;
      end;
   end;
   assign(output,'calcgame.out');
   rewrite(output);
   if answer_count=10000 then
      writeln('Impossible')
   else
      writeln(answer_digit,' ',answer_count);
end.