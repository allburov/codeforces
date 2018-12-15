var
   i,left,right:longint;
begin
   randomize;
   writeln(15000);
   for i:=1 to 15000 do begin
      left:=10000+trunc(random*89000);
      right:=left+random(200);
      writeln(left,' ',right);
   end;
end.