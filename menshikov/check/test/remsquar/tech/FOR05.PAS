const
   n=100;
var
   i,j:integer;
begin
   writeln(n,' ',n);
   for i:=1 to n do begin
      for j:=1 to n do
         write('#');
      writeln;
   end;
end.