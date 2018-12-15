{
must be (x1<>x2) and (y1<>y2)
}
var
   i:integer;
begin
   randomize;
   writeln(100);
   for i:=1 to 100 do
      writeln(random(100),' ',random(100),' ',random(100),' ',random(100));
end.