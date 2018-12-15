{
Written by Fyodor Menshikov 06.05.2002
11:50-11:56
}
type
   integer=longint;
var
   n,k:integer;
   l:array[1..10000]of integer;

   function cut(len:integer):integer;
   var
      sum,i:integer;
   begin
      sum:=0;
      for i:=1 to n do begin
         sum:=sum+l[i] div len;
         if sum>10000 then begin
            cut:=sum;
            exit;
         end;
      end;
      cut:=sum;
   end;

var
   i:integer;
   min,max,mid:integer;
begin
   assign(input,'cable.in');
   reset(input);
   readln(n,k);
   for i:=1 to n do
      readln(l[i]);
   min:=0;
   max:=maxlongint;
   while max>min+1 do begin
      mid:=(min+max)div 2;
      if cut(mid)>=k then
         min:=mid
      else
         max:=mid;
   end;
   assign(output,'cable.out');
   rewrite(output);
   writeln(min);
end.