const
   m=100;
   n=100;
var
   i,j:integer;
begin
   writeln(m,' ',n);
   randomize;
   for i:=1 to m do begin
      for j:=1 to n do
         if random(2)=0 then
            write('#')
         else
            write('.');
      writeln;
   end;
end.