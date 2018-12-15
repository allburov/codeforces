const
   n=100000;
var
   i:longint;
begin
   writeln(n);
   writeln(0,' ',-1);
   writeln(0,' ',1);
   for i:=1 to n div 4-1 do begin
      writeln(i*2-1,' ',1);
      writeln(i*2-1,' ',0);
      writeln(i*2-0,' ',0);
      writeln(i*2-0,' ',1);
   end;
   writeln(n div 4*2-1,' ',1);
   writeln(n div 4*2-1,' ',-1);
end.