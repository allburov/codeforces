const
   n=40;
   k=2;
var
   i:integer;
begin
   randomize;
   writeln(n,' ',k);
   for i:=1 to n do
      if random(10)=0 then
         write('X')
      else
         write('O');
   writeln;
end.