const
   len=60;
   letters=2;
var
   i:integer;
   c:char;
   used:array['A'..'Z']of boolean;
begin
   randomize;
   for c:='A' to 'Z' do
      used[c]:=false;
   for i:=1 to letters do begin
      repeat
         c:=chr(ord('A')+random(26));
      until not used[c];
      used[c]:=true;
   end;
   for i:=1 to len do begin
      repeat
         c:=chr(ord('A')+random(26));
      until used[c];
      write(c);
   end;
   writeln;
end.