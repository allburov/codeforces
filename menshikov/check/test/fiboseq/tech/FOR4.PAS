{$N+,E-}
var
	prev,cur,next:comp;
	len:integer;
begin
	prev:=2000000000;
	write(1,' ',prev:0:0,' ');
	cur:=-1236067977;
	len:=2;
	while true do begin
		next:=cur+prev;
		if (next<-2000000000) or (next>2000000000) then begin
			write(len,' ',cur:0:0);
			break;
		end;
		inc(len);
		prev:=cur;
		cur:=next;
	end;
	writeln;
end.