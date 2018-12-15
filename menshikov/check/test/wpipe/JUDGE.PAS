{
Written by Fyodor Menshikov 19.08.2004
19:35-19:51
Time Ok by 20:10
}
var
   L:array[1..4]of longint;
   C:array[1..4]of integer;
   k:integer;
   min:integer;

   procedure rec(x,y:longint;kind:integer;count:integer);
   var
      cx,cy,abscx,Ckind:integer;
      Lkind:longint;
   begin
      if count>=min then
         exit;
      if kind=1 then begin
         if (abs(x) mod L[1]=0) and (abs(y) mod L[1]=0) then begin
            cx:=abs(x) div L[1];
            cy:=abs(y) div L[1];
            if (cx+cy<=C[1]) and (count+cx+cy<min) then begin
               min:=count+cx+cy;
            end;
         end;
      end
      else begin
         Ckind:=C[kind];
         Lkind:=L[kind];
         for cx:=1 to Ckind-1 do begin
            for cy:=1 to Ckind-cx do begin
               rec(x+cx*Lkind,y+cy*Lkind,kind-1,count+cx+cy);
               rec(x+cx*Lkind,y-cy*Lkind,kind-1,count+cx+cy);
               rec(x-cx*Lkind,y+cy*Lkind,kind-1,count+cx+cy);
               rec(x-cx*Lkind,y-cy*Lkind,kind-1,count+cx+cy);
            end;
         end;
         cx:=0;
         for cy:=1 to Ckind do begin
            rec(x,y+cy*Lkind,kind-1,count+cy);
            rec(x,y-cy*Lkind,kind-1,count+cy);
         end;
         cy:=0;
         for cx:=1 to Ckind do begin
            rec(x+cx*Lkind,y,kind-1,count+cx);
            rec(x-cx*Lkind,y,kind-1,count+cx);
         end;
         rec(x,y,kind-1,count);
      end;
   end;

var
   i:integer;
   x1,y1,x2,y2:longint;
begin
   assign(input,'wpipe.in');
   reset(input);
   assign(output,'wpipe.out');
   rewrite(output);
   read(x1,y1,x2,y2,k);
   for i:=1 to k do
      read(L[i]);
   for i:=1 to k do
      read(C[i]);
   min:=maxint;
   rec(x1-x2,y1-y2,k,0);
   if min=maxint then
      writeln(-1)
   else
      writeln(min);
end.