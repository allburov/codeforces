{
Written by Fyodor Menshikov 11.10.2003
3:15-3:27
}
{$R+,Q+}
type
   integer=longint;
var
   n,i,j:integer;
   value:array[1..100]of integer;
   best:array[1..100,1..100]of integer;

   function func(i1,i2:integer):integer;
   var
      min,cur:integer;
      i:integer;
   begin
      if best[i1,i2]>=0 then
         func:=best[i1,i2]
      else begin
         if i2=i1+1 then
            best[i1,i2]:=0
         else begin
            min:=maxlongint;
            for i:=i1+1 to i2-1 do begin
               cur:=func(i1,i)+func(i,i2)+value[i1]*value[i]*value[i2];
               if cur<min then
                  min:=cur;
            end;
            best[i1,i2]:=min;
         end;
         func:=best[i1,i2];
      end;
   end;

begin
   assign(input,'mpuzzle.in');
   reset(input);
   assign(output,'mpuzzle.out');
   rewrite(output);
   readln(n);
   for i:=1 to n do
      read(value[i]);
   for i:=1 to n do
      for j:=1 to n do
         best[i,j]:=-1;
   writeln(func(1,n));
end.