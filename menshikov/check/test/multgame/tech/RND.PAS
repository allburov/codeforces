{$N+,E-}
const
   a:array[1..16]of comp=(
      1,
      10,
      19,
      163,
      325,
      2917,
      5833,
      52489,
      104977,
      944785,
      1889569,
      17006113,
      34012225,
      306110017,
      612220033,
      4294967296.0
   );
var
   i:integer;
begin
   randomize;
   for i:=low(a) to high(a)-1 do begin
      writeln(a[i]:0:0);
      writeln(int(random*(a[i+1]-a[i]-2))+a[i]+1:0:0);
      writeln(int(random*(a[i+1]-a[i]-2))+a[i]+1:0:0);
      writeln(a[i+1]-1:0:0);
      writeln;
   end;
end.