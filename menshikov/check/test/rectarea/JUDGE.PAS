{
Written by Fyodor Menshikov 05.01.2004
15:33-15:53
by 16:00 -1 (wa2)
}
type
   trect=record
      xmin,ymin,xmax,ymax:integer;
   end;
   tarr=array[1..200]of integer;

   function min(x,y:integer):integer;
   begin
      if x<y then
         min:=x
      else
         min:=y;
   end;

   function max(x,y:integer):integer;
   begin
      if x>y then
         max:=x
      else
         max:=y;
   end;

   procedure readrect(var r:trect);
   var
      x1,y1,x2,y2:integer;
   begin
      readln(x1,y1,x2,y2);
      r.xmin:=min(x1,x2);
      r.xmax:=max(x1,x2);
      r.ymin:=min(y1,y2);
      r.ymax:=max(y1,y2);
   end;

   procedure sort(var a:tarr;count:integer);
   var
      i,j:integer;
      buf:integer;
   begin
      for i:=1 to count do
         for j:=1 to count do
            if (i<j) and (a[i]>a[j]) then begin
               buf:=a[i];
               a[i]:=a[j];
               a[j]:=buf;
            end;
   end;

   procedure killdupes(var a:tarr;var count:integer);
   var
      from:integer;
      _to:integer;
   begin
      _to:=1;
      for from:=2 to count do
         if a[from]<>a[from-1] then begin
            inc(_to);
            a[_to]:=a[from];
         end;
      count:=_to;
   end;

   function belongs(x,y:integer;r:trect):boolean;
   begin
      belongs:=(r.xmin<=x)and(x<r.xmax)and(r.ymin<=y)and(y<r.ymax);
   end;

var
   i,j,k,n:integer;
   r:array[1..100]of trect;
   x,y:tarr;
   xcount,ycount:integer;
   painted:boolean;
   area:longint;
begin
   assign(input,'rectarea.in');
   reset(input);
   assign(output,'rectarea.out');
   rewrite(output);
   readln(n);
   for i:=1 to n do
      readrect(r[i]);
   xcount:=0;
   ycount:=0;
   for i:=1 to n do begin
      inc(xcount);
      x[xcount]:=r[i].xmin;
      inc(xcount);
      x[xcount]:=r[i].xmax;
      inc(ycount);
      y[ycount]:=r[i].ymin;
      inc(ycount);
      y[ycount]:=r[i].ymax;
   end;
   sort(x,xcount);
   killdupes(x,xcount);
   sort(y,ycount);
   killdupes(y,ycount);
   area:=0;
   for i:=1 to xcount-1 do
      for j:=1 to ycount-1 do begin
         painted:=false;
         for k:=1 to n do
            if belongs(x[i],y[j],r[k]) then begin
               painted:=true;
               break;
            end;
         {writeln(x[i],' ',x[i+1],' ',y[j],' ',y[j+1],' ',painted,' ',k);}
         if painted then begin
            area:=area+longint((x[i+1]-x[i]))*(y[j+1]-y[j]);
         end;
      end;
   writeln(area);
end.