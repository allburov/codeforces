const
   n=30;
var
   i,j,k:integer;
begin
   randomize;
   writeln(n);
   for i:=1 to n do begin
      writeln;
      for j:=1 to n do begin
         for k:=1 to n do  
            if (i=n) and (j=n) and (k=1) then
               write('S')
            else if random(3)=0 then
               write('#')
            else
               write('.');
         writeln;
      end;
   end;
end.