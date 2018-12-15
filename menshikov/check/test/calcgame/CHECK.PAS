{
Written by Fyodor Menshikov 17.08.2004
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
   s,js:string;
   i:integer;
begin
   assign(input,'calcgame.out');
   reset(input);
   readln(s);
   if s='Impossible' then
   else begin
      if length(s)<3 then
         pe;
      if not (s[1] in ['1'..'9']) then
         pe;
      if s[2]<>' ' then
         pe;
      if not (s[3] in ['1'..'9']) then
         pe;
      for i:=4 to length(s) do
         if not (s[i] in ['0'..'9']) then
            pe;
   end;
   assign(input,'calcgame.chk');
   reset(input);
   readln(js);
   if s<>js then
      wa;
   ac;
end.