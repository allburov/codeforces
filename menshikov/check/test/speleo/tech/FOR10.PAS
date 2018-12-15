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
            if (i=n) and (j=n) and (k=n) then
               write('S')
            else
               write('.');
         writeln;
      end;
   end;
end.