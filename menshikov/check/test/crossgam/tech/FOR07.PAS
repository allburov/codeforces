const
   n=40;
   k=1;
var
   i:integer;
begin
   randomize;
   writeln(n,' ',k);
   for i:=1 to n do
      if random(2)=0 then
         write('X')
      else
         write('O');
   writeln;
end.