const
   n=30;
var
   i,j,k:integer;
begin
   writeln(n);
   for i:=1 to n do begin
      writeln;
      for j:=1 to n do begin
         for k:=1 to n do
            if (k mod 6=4) and (j<n-1) then
               write('#')
            else if (k mod 6=1) and (j>2) then
               write('#')
            else if (i mod 6=4) and ((j>2) or (k>2)) then
               write('#')
            else if (i mod 6=1) and ((j<n-1) or (k<n-1)) then
               write('#')
            else if (i=n) and (j=1) and (k=n) then
               write('S')
            else
               write('.');
         writeln;
      end;
   end;
end.