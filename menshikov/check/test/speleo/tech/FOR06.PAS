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
            if (k mod 4=3) and (j<n) then
               write('#')
            else if (k mod 4=1) and (j>1) then
               write('#')
            else if (i mod 4=3) and ((j>1) or (k>1)) then
               write('#')
            else if (i mod 4=1) and ((j<n) or (k<n)) then
               write('#')
            else if (i=n) and (j=1) and (k=1) then
               write('S')
            else
               write('.');
         writeln;
      end;
   end;
end.