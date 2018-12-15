{
Written by Fyodor Menshikov 18.04.2004
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
      writeln('Usage: nonegint filename.out filename.chk');
      readln;
      halt;
   end;

var
   out,chk:text;
   c,c1,c2:char;
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
   if eoln(chk) then
      ie('judge file has wrong format');
   read(chk,c);
   if (c='0') and not eoln(chk) then
      ie('judge file has wrong format');
   if not(c in ['0'..'9']) then
      ie('judge file has wrong format');
   while not eoln(chk) do begin
      read(chk,c);
      if not(c in ['0'..'9']) then
         ie('judge file has wrong format');
   end;
   readln(chk);
   if not eof(chk) then
      ie('judge file has wrong format');
   close(chk);
   reset(chk);
   {checking contestant output format}
   if eoln(out) then
      pe;
   read(out,c);
   if (c='0') and not eoln(out) then
      pe;
   if not(c in ['0'..'9']) then
      pe;
   while not eoln(out) do begin
      read(out,c);
      if not(c in ['0'..'9']) then
         pe;
   end;
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
