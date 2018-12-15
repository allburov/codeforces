{
Written by Fyodor Menshikov 11.10.2003
2:00-2:35 (-1)
}
{$M 65520,0,100000}
type
   ca=array[0..101,0..101]of char;
   ia=array[1..10000]of integer;
var
   w,h:integer;
   i,j:integer;
   c:^ca;
   value:array[0..101,0..101]of integer;
   neigh:^ia;{-1 no yet, -2 several}
   isHole:array[1..10000]of char;
   area:^ia;
   holcnt:ia;

   curch:char;
   repch:char;
   curvalue:integer;

   bestholcnt:integer;
   bestarea:integer;

   procedure paint;
   begin
      if c^[i,j]<>curch then
         exit;
      c^[i,j]:=repch;
      value[i,j]:=curvalue;
      inc(area^[curvalue]);

      i:=i+1;
      paint;
      i:=i-1;

      i:=i-1;
      paint;
      i:=i+1;

      j:=j+1;
      paint;
      j:=j-1;

      j:=j-1;
      paint;
      j:=j+1;
   end;

   procedure regpair(v1,v2:integer);
   begin
      if v1=v2 then
         exit;
      if neigh^[v1]=-2 then{several neighbours}
      else if neigh^[v1]=-1 then{none}
         neigh^[v1]:=v2
      else if neigh^[v1]>=0 then begin
         if neigh^[v1]<>v2 then
            neigh^[v1]:=-2;
      end
      else
         halt(1);
      if neigh^[v2]=-2 then{several neighbours}
      else if neigh^[v2]=-1 then{none}
         neigh^[v2]:=v1
      else if neigh^[v2]>=0 then begin
         if neigh^[v2]<>v1 then
            neigh^[v2]:=-2;
      end
      else
         halt(1);
   end;

begin
   assign(input,'holey.in');
   reset(input);
   assign(output,'holey.out');
   rewrite(output);
   new(c);
   new(neigh);
   new(area);
   for i:=0 to 101 do
      for j:=0 to 101 do begin
         c^[i,j]:='!';{main border char}
         value[i,j]:=0;{main border value}
      end;
   readln(w,h);
   for i:=1 to h do begin
      for j:=1 to w do
         read(c^[i,j]);
      readln;
   end;
   curvalue:=0;
   for i:=1 to h do
      for j:=1 to w do
         if value[i,j]=0 then begin
            inc(curvalue);
            isHole[curvalue]:=c^[i,j];
            area^[curvalue]:=0;
            curch:=c^[i,j];
            if curch='*' then
               repch:='#'
            else if curch='.' then
               repch:='+'
            else
               halt(1);
            paint;
         end;
   for i:=1 to curvalue do
      neigh^[i]:=-1;
   for i:=0 to h do
      for j:=0 to w do begin
         regpair(value[i,j],value[i+1,j]);
         regpair(value[i,j],value[i,j+1]);
      end;
   for i:=1 to curvalue do
      if isHole[i]='.' then
         if neigh^[i]>0 then
            inc(holcnt[neigh^[i]]);
   bestholcnt:=0;
   bestarea:=0;
   for i:=1 to curvalue do
      if isHole[i]='*' then begin
         if (holcnt[i]>bestholcnt) or (holcnt[i]=bestholcnt)and(area^[i]<bestarea) then begin
            bestholcnt:=holcnt[i];
            bestarea:=area^[i];
         end;
      end;
   writeln(bestarea);
end.