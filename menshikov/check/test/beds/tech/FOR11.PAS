const
   n=200;
var
   i,j:integer;
begin
   writeln(n,' ',n);
   for i:=1 to n do begin
      for j:=1 to n do
         if ((i mod 4=1)or(i mod 4=2))=odd(j) then
            write('.')
         else
            write('#');
      writeln;
   end;
end.