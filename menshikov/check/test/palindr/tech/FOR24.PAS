const
   len=60;
var
   i:integer;
   l1,l2:char;
begin
   randomize;
   l1:=chr(ord('A')+random(26));
   repeat
      l2:=chr(ord('A')+random(26));
   until l2<>l1;
   for i:=1 to len do begin
      if random(10)=5 then
         write(l1)
      else
         write(l2);
   end;
   writeln;
end.