{
Written by Fyodor Menshikov 12.01.2003
10:59-11:15
Perfect numbers between 1 and maxlongint are
6
28
496
8128
33550336
}
{$R-,Q-}

   function perfect(n:longint):boolean;
   var
      i,addend,sum:longint;
   begin
      sum:=1;
      if sqr(trunc(sqrt(n)))=n then
         sum:=sum-trunc(sqrt(n));
      for i:=2 to trunc(sqrt(n)) do begin
         if n mod i=0 then begin
            addend:=i+n div i;
            if (sum>0) and (addend>n-sum) then begin
               sum:=0;
               break;
            end;
            sum:=sum+addend;
         end;
      end;
      perfect:=sum=n;
   end;

var
   m,n,i:longint;
   absent:boolean;
begin
   assign(input,'perfect.in');
   reset(input);
   assign(output,'perfect.out');
   rewrite(output);
   readln(m,n);
   absent:=true;
   for i:=m to n do begin
      if perfect(i) then begin
         writeln(i);
         absent:=false;
      end;
   end;
   if absent then
      writeln('Absent');
end.