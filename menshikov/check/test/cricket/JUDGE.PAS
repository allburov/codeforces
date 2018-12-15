{
Written by Vyacheslav Yozhkin 27.11.2002
during NEERC2002
Idea by Fyodor Menshikov
}
{38}
var
   i, j, k, n, w, h : integer;
   x, y : array[1..105] of integer;
   xx, yy : integer;
   min_stor, max_stor : integer;
   max_x, max_y : integer;

   function min (x, y : integer) : integer;
   begin
      if x < y then min := x
      else min := y;
   end;

   function max (x, y : integer) : integer;
   begin
      if x < y then max := y
      else max := x;
   end;

begin
   assign (input, 'cricket.in');
   assign (output, 'cricket.out');
   reset (input);
   rewrite (output);
   readln (n, w, h);
   for i := 1 to n do begin
      readln (x[i], y[i]);
   end;
   x[n+1] := 0;
   y[n+1] := 0;
   y[n+2] := h;
   x[n+2] := w;
   inc (n);
   for i := 1 to n+1 do begin
      for j := 1 to n +1 do begin
            xx := x[i];
            yy := y[j];
            min_stor := min (w-xx, h-yy);
            for k := 1 to n+1 do begin
               if (x[k] > xx) and (y[k] > yy) then begin
                  if max (x[k]-xx, y[k]-yy) < min_stor then begin
                     min_stor := max (x[k]-xx, y[k]-yy);
                  end;
               end;
            end;
            if max_stor < min_stor then begin
               max_stor := min_stor;
               max_x := xx;
               max_y := yy;
            end;
      end;
   end;
   if max_stor > 0 then
      writeln (max_x, ' ', max_y, ' ', max_stor)
   else halt (1);
end.