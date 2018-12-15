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
            if (i=1) and (k>5) then
               write('#')
            else if (i<n) and (k=5) then
               write('#')
            else if (i mod 4=3) and not ((j<3)and(k<3)or(j>8)and(k>8)) then
               write('#')
            else if (i<>1) and (i mod 4=1) and not ((j<3)and(k>8)or(j>8)and(k<3)) then
               write('#')
            else if (i=2) and (j=1) and (k=n) then
               write('S')
            else
               write('.');
         writeln;
      end;
   end;
end.