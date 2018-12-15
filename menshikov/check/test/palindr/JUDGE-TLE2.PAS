{
Written by Fyodor Menshikov 13.01.2004
9:48-10:00
TL ok for 25 'A'. And for any small answer, for example:
ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGH
output
6560
answers instantly
I/O filename changed 21.01.2005
}
{$S-}
var
   s:string;

   function count(start,finish:integer):longint;
   var
      i,j:integer;
      result:longint;
   begin
      result:=finish-start+1;{single letters}
      for i:=start to finish-1 do
         for j:=i+1 to finish do
            if s[i]=s[j] then begin
               result:=result+1;
               if i+1<j then
                  result:=result+count(i+1,j-1);
            end;
      count:=result;
   end;

begin
   assign(input,'palindr.in');
   reset(input);
   assign(output,'palindr.out');
   rewrite(output);
   readln(s);
   writeln(count(1,length(s)));
end.