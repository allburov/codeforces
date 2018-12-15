{
Written by Fyodor Menshikov 17.05.2002
13:55-14:04
}
{$N+,E-}
type
   real=extended;
var
   n:integer;
   a,b,min,max,mid:real;

   function ok(h2:real):boolean;
   var
      h1,h3:real;
      i:integer;
   begin
      h1:=a;
      ok:=false;
      for i:=3 to n do begin
         h3:=(h2+1)*2-h1;
         if h3<=0 then
            exit;
         h1:=h2;
         h2:=h3;
      end;
      ok:=true;
      b:=h3;
   end;

begin
   assign(input,'garland.in');
   reset(input);
   readln(n,a);
   min:=-1;
   max:=a;
   while true do begin
      mid:=(max+min)/2;
      if (mid=max) or (mid=min) then
         break;
      if ok(mid) then
         max:=mid
      else
         min:=mid;
   end;
   assign(output,'garland.out');
   rewrite(output);
   writeln(b:0:2);
end.