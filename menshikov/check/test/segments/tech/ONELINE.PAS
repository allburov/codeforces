{
Written by Fyodor Menshikov 27.02.2004
}
{$R+,Q+}
   function between(end1,end2,p:integer):boolean;
   begin
      between:=(end1<=p)and(p<=end2)or(end2<=p)and(p<=end1);
   end;

   procedure printvert(y1,y2,y3,y4:integer);far;
   var
      dot:array[0..4]of integer;
      x,i,j:integer;
   begin
      repeat
         for i:=1 to 4 do
            dot[i]:=-10000+random(20001);
         for i:=1 to 4 do
            for j:=1 to 4 do
               if (i<j)and(dot[i]>dot[j]) then begin
                  dot[0]:=dot[i];
                  dot[i]:=dot[j];
                  dot[j]:=dot[0];
               end;
      until (dot[1]<dot[2]) and (dot[2]<dot[3]) and (dot[3]<dot[4]);
      x:=-10000+random(20001);
      writeln(x,' ',dot[y1]);
      writeln(x,' ',dot[y2]);
      writeln(x,' ',dot[y3]);
      writeln(x,' ',dot[y4]);
   end;

   procedure printhor(x1,x2,x3,x4:integer);far;
   var
      dot:array[0..4]of integer;
      y,i,j:integer;
   begin
      repeat
         for i:=1 to 4 do
            dot[i]:=-10000+random(20001);
         for i:=1 to 4 do
            for j:=1 to 4 do
               if (i<j)and(dot[i]>dot[j]) then begin
                  dot[0]:=dot[i];
                  dot[i]:=dot[j];
                  dot[j]:=dot[0];
               end;
      until (dot[1]<dot[2]) and (dot[2]<dot[3]) and (dot[3]<dot[4]);
      y:=-10000+random(20001);
      writeln(dot[x1],' ',y);
      writeln(dot[x2],' ',y);
      writeln(dot[x3],' ',y);
      writeln(dot[x4],' ',y);
   end;

   procedure printnakl(p1,p2,p3,p4:integer);far;
   var
      dot:array[0..4]of integer;
      i,j,kx,ky,dx,dy:integer;
   begin
      repeat
         for i:=1 to 4 do
            dot[i]:=random(101);
         for i:=1 to 4 do
            for j:=1 to 4 do
               if (i<j)and(dot[i]>dot[j]) then begin
                  dot[0]:=dot[i];
                  dot[i]:=dot[j];
                  dot[j]:=dot[0];
               end;
      until (dot[1]<dot[2]) and (dot[2]<dot[3]) and (dot[3]<dot[4]);
      kx:=random(50)+1;
      ky:=random(50)+1;
      dx:=-10000+random(15001);
      dy:=-10000+random(15001);

      writeln(dot[p1]*kx+dx,' ',dot[p1]*ky+dy);
      writeln(dot[p2]*kx+dx,' ',dot[p2]*ky+dy);
      writeln(dot[p3]*kx+dx,' ',dot[p3]*ky+dy);
      writeln(dot[p4]*kx+dx,' ',dot[p4]*ky+dy);
   end;

   function int2str2(i:integer):string;
   var
      s:string;
   begin
      s:='';
      repeat
         s:=chr(ord('0')+i mod 10)+s;
         i:=i div 10;
      until i=0;
      while length(s)<2 do
         s:='0'+s;
      int2str2:=s;
   end;

type
   showproc=procedure(p1,p2,p3,p4:integer);

   procedure perebor(sp:showproc;dir:string);
   var
      seg1p1,seg1p2,seg2p1,seg2p2:integer;
      used:array[1..4]of boolean;
      i:integer;
      wrong:boolean;
      cnt:integer;
   begin
      cnt:=0;
      for seg1p1:=1 to 4 do
         for seg1p2:=1 to 4 do
            for seg2p1:=1 to 4 do
               for seg2p2:=1 to 4 do begin
                  {if it is point}
                  if seg1p1=seg1p2 then
                     continue;
                  if seg2p1=seg2p2 then
                     continue;
                  {if there is not used point before used}
                  for i:=1 to 4 do
                     used[i]:=false;
                  used[seg1p1]:=true;
                  used[seg1p2]:=true;
                  used[seg2p1]:=true;
                  used[seg2p2]:=true;
                  wrong:=false;
                  for i:=1 to 3 do
                     if not used[i] and used[i+1] then
                        wrong:=true;
                  if wrong then
                     continue;
                  {else OK}
                  inc(cnt);
                  assign(output,dir+'\segments.i'+int2str2(cnt));
                  rewrite(output);
                  {writeln(seg1p1);
                  writeln(seg1p2);
                  writeln(seg2p1);
                  writeln(seg2p2);
                  writeln;}
                  sp(seg1p1,seg1p2,seg2p1,seg2p2);
                  close(output);
                  {writeln;}
                  assign(output,dir+'\segments.o'+int2str2(cnt));
                  rewrite(output);
                  if between(seg1p1,seg1p2,seg2p1)or
                     between(seg1p1,seg1p2,seg2p2)or
                     between(seg2p1,seg2p2,seg1p1)or
                     between(seg2p1,seg2p2,seg1p2)
                  then
                     writeln('Yes')
                  else
                     writeln('No');
                  {writeln('-----');}
                  close(output);
               end;
   end;

begin 
   randomize;
   {writeln('~~~~~vert~~~~~');}
   mkdir('v');
   perebor(printvert,'v');
   {writeln('~~~~~hor~~~~~');}
   mkdir('h');
   perebor(printhor,'h');
   {writeln('~~~~~nakl~~~~~');}
   mkdir('n');
   perebor(printnakl,'n');
end.