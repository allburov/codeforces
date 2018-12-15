{
Written by Fyodor Menshikov 19.04.2004
}
   procedure ac;
   begin
      writeln('a');
      halt(0);
   end;

   procedure wa;
   begin
      writeln('wa');
      halt(1);
   end;

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

   procedure ie(message:string);
   begin
      writeln('Internal error: ',message);
      readln;
      halt;
   end;

   procedure usage;
   begin 
      writeln('Usage: nnfixed filename.out filename.chk');
      readln;
      halt;
   end;

   procedure nextchar(var f:text;var c:char);
   begin
   	if eoln(f) then
   		c:=#13
   	else
   		read(f,c);
   end;

var
   out,chk:text;
   c,c1,c2:char;
   digits_judge,digits_user:longint;
begin
   if paramcount<>2 then
      usage;
   assign(out,paramstr(1));
   {$I-}
   reset(out);
   {$I+}
   if ioresult<>0 then
      ie('cannot open contestant output '+paramstr(1));
   assign(chk,paramstr(2));
   {$I-}
   reset(chk);
   {$I+}
   if ioresult<>0 then
      ie('cannot open judge output '+paramstr(2));
   {checking judge output format}
   nextchar(chk,c);
   if c='0' then
   	nextchar(chk,c)
   else if c in ['1'..'9'] then begin
   	nextchar(chk,c);
   	while c in ['0'..'9'] do
   		nextchar(chk,c);
   end
   else
      ie('judge file has wrong format');
   if c<>'.' then
   	ie('judge file has wrong format');
   nextchar(chk,c);
   if c in ['0'..'9'] then
   	nextchar(chk,c)
   else
   	ie('judge file has wrong format');
   digits_judge:=1;
   while c in ['0'..'9'] do begin
   	inc(digits_judge);
   	nextchar(chk,c);
   end;
   if c<>#13 then
   	ie('judge file has wrong format');
   readln(chk);
   if not eof(chk) then
      ie('judge file has wrong format');
   close(chk);
   reset(chk);
   {checking contestant output format}
   nextchar(out,c);
   if c='0' then
   	nextchar(out,c)
   else if c in ['1'..'9'] then begin
   	nextchar(out,c);
   	while c in ['0'..'9'] do
   		nextchar(out,c);
   end
   else
      pe;
   if c<>'.' then
   	pe;
   nextchar(out,c);
   if c in ['0'..'9'] then
   	nextchar(out,c)
   else
   	pe;
   digits_user:=1;
   while c in ['0'..'9'] do begin
   	inc(digits_user);
   	if digits_user>digits_judge then
   		pe;
   	nextchar(out,c);
   end;
   if digits_user<digits_judge then
   	pe;
   if c<>#13 then
   	pe;
   readln(out);
   if not eof(out) then
      pe;
   close(out);
   reset(out);
   {checking equality}
   while true do begin
      if eoln(out) and eoln(chk) then
         ac;
      if eoln(out) then
         wa;
      if eoln(chk) then
         wa;
      read(out,c1);
      read(chk,c2);
      if c1<>c2 then
         wa;
   end;
end.
