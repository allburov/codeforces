{$N+,E-}
var
	prev,cur,next,first,second:comp;
	len:integer;
begin
	first:=2000000000;
	second:=-1237000000;
	while second<=-1235000000 do begin
		prev:=first;
		cur:=second;
		len:=2;
		while true do begin
			next:=cur+prev;
			if (next<-2000000000) or (next>2000000000) then
				break;
			inc(len);
			prev:=cur;
			cur:=next;
		end;
		writeln(second:0:0,' ',len);
		second:=second+1000;
	end;
end.