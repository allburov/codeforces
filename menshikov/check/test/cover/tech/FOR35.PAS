var
   i,left,right:longint;
begin
   randomize;
   writeln(15000);
   for i:=1 to 15000 do begin
      right:=10000+trunc(random*90000);
      writeln(-right,' ',right);
   end;
end.