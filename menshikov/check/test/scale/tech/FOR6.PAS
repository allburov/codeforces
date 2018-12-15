	function tochar(d:integer):char;
   begin
   	if d<10 then
      	tochar:=chr(ord('0')+d)
      else
      	tochar:=chr(ord('A')+d-10);
   end;

var
	i:integer;
begin
	assign(output,'scale.i04');
   rewrite(output);
   writeln(15,' ',3);
   for i:=1 to 1000 do
   	write(tochar(random(15)));
   writeln;

   close(output);
end.
