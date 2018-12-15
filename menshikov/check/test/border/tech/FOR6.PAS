const
   n=100000;
   mlrd=1000000000;
var
   i:longint;
begin
   writeln(n);
   writeln(0,' ',-mlrd);
   writeln(0,' ',mlrd);
   for i:=1 to n div 4-1 do begin
      writeln(i*2-1,' ',mlrd);
      writeln(i*2-1,' ',-mlrd+1);
      writeln(i*2-0,' ',-mlrd+1);
      writeln(i*2-0,' ',mlrd);
   end;
   writeln(n div 4*2-1,' ',mlrd);
   writeln(n div 4*2-1,' ',-mlrd);
end.