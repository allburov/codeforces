{
Written by Fyodor Menshikov 15.08.2004
20:20-20:25
}
type
   integer=longint;
var
   m,n,t,mcount,ncount,tlast,maxsum,mintime:integer;
begin
   assign(input,'homer.in');
   reset(input);
   assign(output,'homer.out');
   rewrite(output);
   readln(m,n,t);
   maxsum:=maxlongint;
   mintime:=maxlongint;
   for mcount:=0 to t div m do begin
      ncount:=(t-m*mcount) div n;
      tlast:=t-m*mcount-n*ncount;
      if (tlast<mintime)or(tlast=mintime)and(mcount+ncount>maxsum) then begin
         mintime:=tlast;
         maxsum:=mcount+ncount;
      end;
   end;
   if mintime=maxlongint then
      halt(1);
   write(maxsum);
   if mintime<>0 then
      write(' ',mintime);
   writeln;
end.