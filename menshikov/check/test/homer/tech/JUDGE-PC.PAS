var
	burg:array[0..10000]of integer;
   max,i,m,n,t:integer;
begin
	assign(input,'homer.in');
	reset(input);
	assign(output,'homer.out');
	rewrite(output);
   	readln(m,n,t);
   	for i:=1 to t do
      	burg[i]:=-1;
      burg[0]:=0;
      for i:=1 to t do begin
      	if (i>=m) and (burg[i-m]>=0) then begin
         	if burg[i-m]+1>burg[i] then
            	burg[i]:=burg[i-m]+1;
         end;
         if (i>=n) and (burg[i-n]>=0) then begin
         	if burg[i-n]+1>burg[i] then
            	burg[i]:=burg[i-n]+1;
         end;
      end;
      if burg[t]>-1 then
      	writeln(burg[t])
      else begin
      	for i:=t-1 downto 0 do
         	if burg[i]>=0 then begin
            	writeln(burg[i],' ',t-i);
               break;
            end;
      end;
end.