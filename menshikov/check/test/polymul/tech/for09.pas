type
   TPoly=array[0..10]of integer;

   procedure rnd(var p:TPoly);
   var
      i:integer;
   begin
      for i:=0 to 10 do
         case random(5) of
         0:
            p[i]:=0;
         1:
            p[i]:=1;
         2:
            p[i]:=-1;
         3:
            p[i]:=random(9999)+2;
         4:
            p[i]:=-2-random(9999);
         end;
   end;

   procedure showMono(coef, pow: integer);
   begin
      if coef <= 0 then
         halt(1);
      if pow = 0 then
         write(coef)
      else begin
         if coef <> 1 then
            write(coef);
         write('x');
         if pow <> 1 then
            write('^',pow);
      end;
   end;

   procedure show(p: tPoly);
   var
      i: integer;
   begin
      i := high(p);
      while (i > 0) and (p[i] = 0) do
         dec(i);

      if p[i] < 0 then begin
         write('-');
         showMono(-p[i], i);
      end
      else if p[i] > 0 then
         showMono(p[i], i)
      else
         write(0);{i = 0}

      for i := i - 1 downto 0 do begin
         if p[i] < 0 then begin
            write('-');
            showMono(-p[i], i);
         end
         else if p[i] > 0 then begin
            write('+');
            showMono(p[i], i);
         end;
      end;
      writeln;
   end;

var
   p:TPoly;
begin
   randomize;
   rnd(p);
   show(p);
   rnd(p);
   show(p);
end.