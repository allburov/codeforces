{
Written by Fyodor Menshikov 25.05.2004
10:52-11:10,11:21-12:00
debugged by 12:20, problem in idea
12:30-12:43 OK
Total 18+39+13=1:10+debug 0:20+idea correction 0:10
}
{-$define debug}
{$R+,Q+}
type
   point=record
      x,y:integer;
   end;
   hsegment=record
      xmin,xmax,y:integer;
   end;
   vsegment=record
      x,ymin,ymax:integer;
   end;
   rectangle=record
      xmin,ymin,xmax,ymax:integer;
   end;

   function point_cmp(x1,y1,x2,y2:integer):integer;
   begin
      if x1<x2 then
         point_cmp:=-1
      else if x1>x2 then
         point_cmp:=1
      else if y1<y2 then
         point_cmp:=-1
      else if y1>y2 then
         point_cmp:=1
      else
         point_cmp:=0;
   end;

   function rect_common(r1,r2:rectangle):boolean;
   var
      outside,inside12,inside21:boolean;
   begin
      outside:=
         (r1.xmin>r2.xmax) or (r2.xmin>r1.xmax) or
         (r1.ymin>r2.ymax) or (r2.ymin>r1.ymax);
      inside12:=
         (r1.xmin>r2.xmin) and (r1.xmax<r2.xmax) and
         (r1.ymin>r2.ymin) and (r1.ymax<r2.ymax);
      inside21:=
         (r2.xmin>r1.xmin) and (r2.xmax<r1.xmax) and
         (r2.ymin>r1.ymin) and (r2.ymax<r1.ymax);
      rect_common:=not outside and not inside12 and not inside21;
   end;

var
   rects:array[1..100]of rectangle;
   rect_num:integer;

   procedure read_rect(var r:rectangle);
   var
      x1,y1,x2,y2:integer;
   begin
      readln(x1,y1,x2,y2);
      if x1<x2 then begin
         r.xmin:=x1;
         r.xmax:=x2;
      end
      else begin
         r.xmin:=x2;
         r.xmax:=x1;
      end;
      if y1<y2 then begin
         r.ymin:=y1;
         r.ymax:=y2;
      end
      else begin
         r.ymin:=y2;
         r.ymax:=y1;
      end;
   end;

   procedure read_data;
   var
      i:integer;
   begin
      readln(rect_num);
      for i:=1 to rect_num do
         read_rect(rects[i]);
   end;

var
   points:array[1..400]of point;
   point_num:integer;

   procedure add_point(x,y:integer);
   var
      i:integer;
   begin
      for i:=1 to point_num do
         if point_cmp(x,y,points[i].x,points[i].y)=0 then
            exit;
      inc(point_num);
      points[point_num].x:=x;
      points[point_num].y:=y;
   end;

   procedure add_rect_points(r:rectangle);
   begin
      add_point(r.xmin,r.ymin);
      add_point(r.xmin,r.ymax);
      add_point(r.xmax,r.ymin);
      add_point(r.xmax,r.ymax);
   end;

   procedure extract_points;
   var
      i:integer;      
   begin
      point_num:=0;
      for i:=1 to rect_num do
         add_rect_points(rects[i]);
   end;

var
   hsegs:array[1..200]of hsegment;
   hseg_num:integer;

   procedure add_rect_hsegs(r:rectangle);
   begin
      inc(hseg_num);
      hsegs[hseg_num].xmin:=r.xmin;
      hsegs[hseg_num].xmax:=r.xmax;
      hsegs[hseg_num].y:=r.ymin;
      inc(hseg_num);
      hsegs[hseg_num].xmin:=r.xmin;
      hsegs[hseg_num].xmax:=r.xmax;
      hsegs[hseg_num].y:=r.ymax;
   end;

   procedure extract_hsegs;
   var
      i:integer;
   begin
      hseg_num:=0;
      for i:=1 to rect_num do
         add_rect_hsegs(rects[i]);
   end;

var
   vsegs:array[1..200]of vsegment;
   vseg_num:integer;

   procedure add_rect_vsegs(r:rectangle);
   begin
      inc(vseg_num);
      vsegs[vseg_num].ymin:=r.ymin;
      vsegs[vseg_num].ymax:=r.ymax;
      vsegs[vseg_num].x:=r.xmin;
      inc(vseg_num);
      vsegs[vseg_num].ymin:=r.ymin;
      vsegs[vseg_num].ymax:=r.ymax;
      vsegs[vseg_num].x:=r.xmax;
   end;

   procedure extract_vsegs;
   var
      i:integer;
   begin
      vseg_num:=0;
      for i:=1 to rect_num do
         add_rect_vsegs(rects[i]);
   end;

var
   edge_num:integer;

   procedure find_points_edges;
   var
      i,j:integer;
      toXmin,toXmax,toYmin,toYmax:boolean;
   begin
      for i:=1 to point_num do begin
         toXmin:=false;
         toXmax:=false;
         toYmin:=false;
         toYmax:=false;
         for j:=1 to hseg_num do begin
            if hsegs[j].y<>points[i].y then
               continue;
            if hsegs[j].xmin>points[i].x then
               continue;
            if hsegs[j].xmax<points[i].x then
               continue;
            if hsegs[j].xmin<points[i].x then
               toXmin:=true;
            if hsegs[j].xmax>points[i].x then
               toXmax:=true;
         end;
         for j:=1 to vseg_num do begin
            if vsegs[j].x<>points[i].x then
               continue;
            if vsegs[j].ymin>points[i].y then
               continue;
            if vsegs[j].ymax<points[i].y then
               continue;
            if vsegs[j].ymin<points[i].y then
               toYmin:=true;
            if vsegs[j].ymax>points[i].y then
               toYmax:=true;
         end;
         if toXmin then
            inc(edge_num);
         if toXmax then
            inc(edge_num);
         if toYmin then
            inc(edge_num);
         if toYmax then
            inc(edge_num);
      end;
   end;

type
   i30k=array[1..30000]of integer;
var
   intersect_num:integer;
   ix,iy:^i30k;

   procedure init_intersect_table;
   begin
      intersect_num:=0;
      new(ix);
      new(iy);
   end;

   procedure add_intersection(x,y:integer);
   begin
      inc(intersect_num);
      ix^[intersect_num]:=x;
      iy^[intersect_num]:=y;
   end;

   procedure add_points_as_intersections;
   var
      i:integer;
   begin
      for i:=1 to point_num do
         add_intersection(points[i].x,points[i].y);
   end;

   procedure find_intersections;
   var
      ih,iv:integer;
   begin
      for ih:=1 to hseg_num do
         for iv:=1 to vseg_num do begin
            if hsegs[ih].y<=vsegs[iv].ymin then
               continue;
            if hsegs[ih].y>=vsegs[iv].ymax then
               continue;
            if vsegs[iv].x<=hsegs[ih].xmin then
               continue;
            if vsegs[iv].x>=hsegs[ih].xmax then
               continue;
            add_intersection(vsegs[iv].x,hsegs[ih].y);
         end;
   end;

   procedure sorti(left,right:word);
   var
      keyx,keyy:integer;
      bufx,bufy:integer;
      i,j:word;
   begin
      keyx:=ix^[(left+right)div 2];
      keyy:=iy^[(left+right)div 2];
      i:=left;
      j:=right;
      repeat
         while point_cmp(ix^[i],iy^[i],keyx,keyy)<0 do
            inc(i);
         while point_cmp(keyx,keyy,ix^[j],iy^[j])<0 do
            dec(j);
         if i<=j then begin
            bufx:=ix^[i];
            ix^[i]:=ix^[j];
            ix^[j]:=bufx;
            bufy:=iy^[i];
            iy^[i]:=iy^[j];
            iy^[j]:=bufy;
            inc(i);
            dec(j);
         end;
      until i>j;
      if left<j then
         sorti(left,j);
      if i<right then
         sorti(i,right);
   end;

   procedure count_ints(var cnt:integer);
   var
      prev,i:integer;
   begin
      cnt:=1;
      prev:=1;
      for i:=2 to intersect_num do
         if point_cmp(ix^[i],iy^[i],ix^[prev],iy^[prev])<>0 then begin
            inc(cnt);
            prev:=i;
         end;
   end;

var
   colored:array[1..100]of boolean;

   procedure paint(i:integer);
   var
      j:integer;
   begin
      colored[i]:=true;
      for j:=1 to rect_num do
         if i<>j then
            if not colored[j] and rect_common(rects[i],rects[j]) then
               paint(j);
   end;

   function coherent:integer;
   var
      i:integer;
      cnt:integer;
   begin
      for i:=1 to rect_num do
         colored[i]:=false;
      cnt:=0;
      for i:=1 to rect_num do
         if not colored[i] then begin
            inc(cnt);
            paint(i);
         end;
      coherent:=cnt;
   end;

var
   diff_int_num:integer;
   V,E,F,C:integer;
begin
   assign(input,'rectpart.in');
   reset(input);
   assign(output,'rectpart.out');
   rewrite(output);
   read_data;
   extract_points;
   {$ifdef debug}
   writeln('point_num=',point_num);
   {$endif}
   extract_hsegs;
   {$ifdef debug}
   writeln('hseg_num=',hseg_num);
   {$endif}
   extract_vsegs;
   {$ifdef debug}
   writeln('vseg_num=',vseg_num);
   {$endif}
   edge_num:=0;
   find_points_edges;
   {$ifdef debug}
   writeln('rectangle vertices edge_num=',edge_num);
   {$endif}
   init_intersect_table;
   add_points_as_intersections;
   find_intersections;
   sorti(1,intersect_num);
   count_ints(diff_int_num);
   {$ifdef debug}
   writeln('intersections + vertices=',diff_int_num);
   {$endif}
   V:=diff_int_num;{points included}
   {$ifdef debug}
   writeln('V=',V);
   {$endif}
   E:=edge_num+(diff_int_num-point_num)*4;
   if E mod 2<>0 then
      halt(1);
   E:=E div 2;
   {$ifdef debug}
   writeln('E=',E);
   {$endif}
   C:=coherent;
   F:=1-V+E+C;
   writeln(F);
end.