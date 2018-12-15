
   function isPrime(n:longint):boolean;
   var
      i:longint;
   begin
      isPrime:=false;
      for i:=2 to trunc(sqrt(n)) do
         if n mod i=0 then
            exit;
      isPrime:=true;
   end;
var
   x,y,dx,dy,p,i:longint;
begin
   x:=0;
   y:=0;
   p:=1000000000;
   writeln(3);
   writeln(0,' ',0);
   repeat
      dec(p);
   until isPrime(p);
   dx:=p;
   repeat
      dec(p);
   until isPrime(p);
   dy:=p;
   x:=x+dx;
   y:=y+dy;
   writeln(x,' ',y);
   writeln(x-10,' ',10);
end.