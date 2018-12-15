const
   n=200;
var
   i,j:integer;
begin
   writeln(n,' ',n);
   for j:=1 to n do begin
      for i:=1 to n do begin
         if i mod 2=1 then begin
            if (i mod 4=1)and(j=1)or(i mod 4=3)and(j=n) then
               write('#')
            else
               write('.');
         end
         else
            write('#');
      end;
      writeln;
   end;
end.