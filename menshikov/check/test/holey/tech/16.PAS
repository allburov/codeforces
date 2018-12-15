var
   i,j:integer;
begin
   writeln(100,' ',100);
   for i:=1 to 100 do begin
      for j:=1 to 100 do
         if odd(i+j) then
            write('.')
         else
            write('*');
      writeln;
   end;
end.