var
   i:longint;
begin
   writeln(15000);
   for i:=15000 downto 1 do
      writeln(10000+i*2,' ',10001+i*2);
end.