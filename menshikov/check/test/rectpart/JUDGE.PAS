{
Written by Fyodor Menshikov 14.09.2002
during training
}
type
   trect=record
      xlo,ylo,xhi,yhi:integer;
   end;
   tset=set of 1..100;
   a202=array[0..202]of integer;
var
   n:integer;
   rect:array[1..100]of trect;
   xs,ys:a202;
   xcount,ycount:integer;

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

   procedure read_rect(var r:trect);
   var
      x1,y1,x2,y2:integer;
   begin
      readln(x1,y1,x2,y2);
      r.xlo:=min(x1,x2);
      r.ylo:=min(y1,y2);
      r.xhi:=max(x1,x2);
      r.yhi:=max(y1,y2);
      if (x1=x2)or(y1=y2) then
         halt(1);
      inc(xcount);
      xs[xcount]:=x1;
      inc(xcount);
      xs[xcount]:=x2;
      inc(ycount);
      ys[ycount]:=y1;
      inc(ycount);
      ys[ycount]:=y2;
   end;

   procedure grid_init;
   begin
      xs[1]:=-10001;
      xcount:=1;
      ys[1]:=-10001;
      ycount:=1;
   end;

   procedure read_data;
   var
      i:integer;
   begin
      readln(n);
      grid_init;
      for i:=1 to n do
         read_rect(rect[i]);
   end;

   procedure grid_finish;
   var
      sorted,compressed:a202;
      scount,ccount:integer;

      procedure compress;
      var
         i:integer;
      begin
         sorted[0]:=sorted[1]-1;
         ccount:=0;
         for i:=1 to scount do
            if sorted[i]<>sorted[i-1] then begin
               inc(ccount);
               compressed[ccount]:=sorted[i];
            end;
      end;

   var
      i,j,buf:integer;
   begin
      {writeln('x:');
      for i:=1 to xcount do
         writeln(xs[i]);
      writeln('-');}
      for i:=1 to xcount do
         for j:=1 to xcount do
            if (i<j)and(xs[i]>xs[j]) then begin
               buf:=xs[i];
               xs[i]:=xs[j];
               xs[j]:=buf;
            end;
      sorted:=xs;
      scount:=xcount;
      compress;
      xcount:=ccount;
      xs:=compressed;
      {writeln('x:');
      for i:=1 to xcount do
         writeln(xs[i]);
      writeln('-');}
      {writeln('y:');
      for i:=1 to ycount do
         writeln(ys[i]);
      writeln('-');}
      for i:=1 to ycount do
         for j:=1 to ycount do
            if (i<j)and(ys[i]>ys[j]) then begin
               buf:=ys[i];
               ys[i]:=ys[j];
               ys[j]:=buf;
            end;
      sorted:=ys;
      scount:=ycount;
      compress;
      ycount:=ccount;
      ys:=compressed;
      {writeln('y:');
      for i:=1 to ycount do
         writeln(ys[i]);
      writeln('-');}
   end;

var
   painted:array[1..202,1..202]of boolean;
type
   tqueue=array[1..50000]of byte;
var
   qx,qy:^tqueue;
   qstart,qend:longint;

   procedure addq(i,j:integer);
   begin
      inc(qend);
      qx^[qend]:=i;
      qy^[qend]:=j;
      painted[i,j]:=true;
   end;

   function notempty:boolean;
   begin
      notempty:=qstart<qend;
   end;

   procedure get(var x,y:integer);
   begin
      inc(qstart);
      x:=qx^[qstart];
      y:=qy^[qstart];
   end;

   procedure cover(i,j:integer;var rez:tset);
   var
      x,y:integer;
   begin
      rez:=[];
      x:=xs[i];
      y:=ys[j];
      for i:=1 to n do
         if (x>=rect[i].xlo)and(y>=rect[i].ylo)and(x<rect[i].xhi)and(y<rect[i].yhi) then
            include(rez,i);
   end;

   procedure paint(x,y:integer);
   var
      coverxy,t:tset;
   begin
      addq(x,y);
      while notempty do begin
         get(x,y);
         cover(x,y,coverxy);
         if (x<xcount)and not painted[x+1,y] then begin
            cover(x+1,y,t);
            if t=coverxy then
               addq(x+1,y);
         end;
         if (y<ycount)and not painted[x,y+1] then begin
            cover(x,y+1,t);
            if t=coverxy then
               addq(x,y+1);
         end;
         if (x>1)and not painted[x-1,y] then begin
            cover(x-1,y,t);
            if t=coverxy then
               addq(x-1,y);
         end;
         if (y>1)and not painted[x,y-1] then begin
            cover(x,y-1,t);
            if t=coverxy then
               addq(x,y-1);
         end;
      end;
   end;

   procedure main;
   var
      i,j:integer;
      count:longint;
   begin
      for i:=1 to xcount do
         for j:=1 to ycount do
            painted[i,j]:=false;
      count:=0;
      new(qx);
      new(qy);
      qstart:=0;
      qend:=0;
      for i:=1 to xcount do
         for j:=1 to ycount do
            if not painted[i,j] then begin
               inc(count);
               {writeln('paint ',i,',',j);}
               paint(i,j);
            end;
      writeln(count);
   end;

begin
   assign(input,'rectpart.in');
   reset(input);
   assign(output,'rectpart.out');
   rewrite(output);
   read_data;
   grid_finish;
   main;
end.