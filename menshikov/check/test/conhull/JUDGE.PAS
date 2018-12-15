{
Written by Fyodor Menshikov 26.12.2003
23:03-23:21
I/O name changed 19.08.2004
I/O filename changed 12.01.2005
}
{$N+,E-}
type
   integer=longint;
   real=extended;
   tPoint=record
      x,y:integer;
   end;
var
   n:integer;
   pt:array[1..1000]of tPoint;

   function chull:real;
   var
      first,cur,next:integer;
      i:integer;
      dx,dy:real;
      sp:real;
      len,cos,bestlen,bestcos:real;
      sum:real;
   begin
      first:=1;
      for i:=2 to n do begin
         if (pt[i].y<pt[first].y)or
            (pt[i].y=pt[first].y)and(pt[i].x<pt[first].x)
         then
            first:=i;
      end;
      dx:=-1;
      dy:=0;
      cur:=first;
      sum:=0;
      repeat
         bestlen:=0;
         bestcos:=-2;
         next:=0;
         for i:=1 to n do begin
            len:=sqrt(sqr(pt[i].x-pt[cur].x)+sqr(pt[i].y-pt[cur].y));
            if len=0 then
               continue;{same point}
            sp:=dx*(pt[i].x-pt[cur].x)+dy*(pt[i].y-pt[cur].y);
            cos:=sp/len;
            if (cos>bestcos)or(cos=bestcos)and(len>bestlen) then begin
               bestcos:=cos;
               bestlen:=len;
               next:=i;
            end;
         end;
         if next=0 then begin
            chull:=0;{others points not found}
            exit;
         end;
         sum:=sum+bestlen;
         dx:=(pt[next].x-pt[cur].x)/bestlen;
         dy:=(pt[next].y-pt[cur].y)/bestlen;
         cur:=next;
      until cur=first;
      chull:=sum;
   end;

var
   i:integer;
begin
   assign(input,'conhull.in');
   reset(input);
   assign(output,'conhull.out');
   rewrite(output);
   readln(n);
   for i:=1 to n do
      readln(pt[i].x,pt[i].y);
   writeln(chull:0:1);
end.