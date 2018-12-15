{$I+}
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

   procedure ie(message:string);
   begin
      writeln('Internal error: ',message);
      readln;
   end;

var
   l1,l2:longint;
   f1,f2:text;
begin
   if paramcount<>2 then
      ie('2 parameters required');
   assign(f1,paramstr(1));
   reset(f1);
   assign(f2,paramstr(2));
   reset(f2);
   while true do begin
      if seekeof(f1) and seekeof(f2) then
         ac;
      if seekeof(f1) or seekeof(f2) then
         wa;
      read(f1,l1);
      read(f2,l2);
      if l1<>l2 then
         wa;
   end;
end.