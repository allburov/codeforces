var
	i:longint;
begin
	for i:=1 to 15 do
		writeln((1 shl i)*(1 shl (i+1) - 1));
end.