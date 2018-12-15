{
Written by Fyodor Menshikov 22.11.2003
11:46-12:36 (+2)
}
{$N+,E-}{-$R+,Q+}
{-$define debug}
type
   real=extended;
var
   points3:integer;
   x3,y3:array[1..1000]of real;

   function area:real;
   var
      i:integer;
      s:real;
   begin
      s:=0;
      for i:=3 to points3 do
         s:=s+(x3[i]-x3[1])*(y3[i-1]-y3[1])-(x3[i-1]-x3[1])*(y3[i]-y3[1]);
      area:=abs(s/2);
   end;

var
   points2:integer;
   x2,y2:array[1..1000]of real;

   function chull:real;
   var
      i,mini,starti,curi,nexti:integer;
      minx,miny:real;
      dx,dy:real;
      dx2,dy2,len:real;
      nextdx,nextdy:real;
      maxsp:real;
   begin
      {$ifdef debug}
      writeln('Chull array:');
      for i:=1 to points2 do
         writeln(x2[i]:0:1,' ',y2[i]:0:1);
      writeln;
      {$endif}

      minx:=x2[1];
      miny:=y2[1];
      mini:=1;
      for i:=2 to points2 do
         if (y2[i]<miny) or (y2[i]=miny) and (x2[i]<minx) then begin
            miny:=y2[i];
            minx:=x2[i];
            mini:=i;
         end;
      starti:=mini;
      curi:=mini;
      dx:=-1;
      dy:=0;
      points3:=0;
      repeat
         
         {$ifdef debug}writeln('chull current ',curi);{$endif}
         maxsp:=-1e100;
         for i:=1 to points2 do begin
            if i<>curi then begin
               dx2:=x2[i]-x2[curi];
               dy2:=y2[i]-y2[curi];
               len:=sqrt(sqr(dx2)+sqr(dy2));
               if len=0 then
                  continue;
                  {while true do;}
               dx2:=dx2/len;
               dy2:=dy2/len;
               if dx*dx2+dy*dy2>maxsp then begin
                  maxsp:=dx*dx2+dy*dy2;
                  nexti:=i;
                  nextdx:=dx2;
                  nextdy:=dy2;
               end;
               {$ifdef debug}writeln('to ',i,' sp=',dx*dx2+dy*dy2:0:5);{$endif}
            end;
         end;
         if maxsp=-1e100 then begin
            chull:=0;
            exit;
         end;
         {$ifdef debug}writeln('choosen ',nexti);{$endif}
         inc(points3);
         x3[points3]:=x2[nexti];
         y3[points3]:=y2[nexti];
         dx:=nextdx;
         dy:=nextdy;
         curi:=nexti;
      until curi=starti;
      chull:=area;
   end;

var
   n,i,i2,j,points:integer;
   start,mouth,tribof,k:array[1..10]of integer;
   x,y:array[1..1000]of real;
   curs,maxs:real;
begin
   assign(input,'basin.in');
   reset(input);
   assign(output,'basin.out');
   rewrite(output);
   readln(n);
   points:=0;
   for i:=1 to n do begin
      readln(k[i]);
      start[i]:=points+1;
      for j:=1 to k[i] do begin
         inc(points);
         readln(x[points],y[points]);
      end;
      mouth[i]:=points;
      tribof[i]:=i;
   end;
   {writeln('loaded');
   halt;}
   for i:=1 to n do
      for i2:=1 to n do
         if i<>i2 then
            for j:=start[i2] to mouth[i2] do
               if (x[mouth[i]]=x[j]) and (y[mouth[i]]=y[j]) then
                  tribof[i]:=i2;
   {writeln('tributes found');
   halt;}
   for j:=1 to n do
      for i:=1 to n do
         for i2:=1 to n do
            if (tribof[i2]=i)and(tribof[i]<>i) then
               tribof[i2]:=tribof[i];
   {writeln('tributes found 2');
   for i:=1 to n do
      write(tribof[i],' ');
   halt;}
   maxs:=0;
   for i:=1 to n do
      if tribof[i]=i then begin
         points2:=0;
         for i2:=1 to n do
            if tribof[i2]=i then
               for j:=start[i2] to mouth[i2] do begin
                  inc(points2);
                  x2[points2]:=x[j];
                  y2[points2]:=y[j];
               end;
         curs:=chull;
         {writeln('curs=',curs);}
         if curs>maxs then
            maxs:=curs;
      end;
   writeln(maxs:0:2);
end.