const
   n=10;
var
   i,j,k:integer;
begin
   writeln(n);
   for i:=1 to n do begin
      writeln;
      for j:=1 to n do begin
         for k:=1 to n do
            if (i mod 4=1) and ((j>3) or (k>3)) then
               write('#')
            else if (i mod 4=3) and ((j<8) or (k<8)) then
               write('#')
            else if (i=n) and (j=n) and (k=n) then
               write('S')
            else
               write('.');
         writeln;
      end;
   end;
end.