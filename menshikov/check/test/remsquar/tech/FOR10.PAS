const
   n=100;
var
   i,j:integer;
begin
   writeln(n,' ',n);
   for i:=1 to n do begin
      for j:=1 to n do
         if odd(i+j) then
            write('.')
         else
            write('#');
      writeln;
   end;
end.