{
Written by Fyodor Menshikov 16.08.2004
}
   procedure ac;
   begin
      writeln('a');
      halt;
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

var
   s:string;
   r,ok:real;
   e:integer;
begin
   assign(input,'tria-abm.chk');
   reset(input);
   readln(ok);

   assign(input,'tria-abm.out');
   reset(input);
   read(s);
   if not eoln then
      pe;
   readln;
   if not eof then
      pe;

   if s='0' then begin
      if ok=0 then
         ac
      else
         wa;
   end
   else if s='-1' then begin
      if ok=-1 then
         ac
      else
         wa;
   end
   else begin
      val(s,r,e);
      if e<>0 then
         pe;
      if r<0 then
         pe;
      if abs(r-ok)<0.0011 then
         ac
      else
         wa;
   end;
end.