{$N+,E-}
var
	prev,cur,next,first,second:comp;
	len:integer;
begin
	first:=2000000000;
	second:=-1236069000;
	while second<=-1236067000 do begin
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
		second:=second+1;
	end;
end.