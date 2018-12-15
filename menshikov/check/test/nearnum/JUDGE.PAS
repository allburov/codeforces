{
Written by Fyodor Menshikov 15.11.2003
10:53-11:16
I/O filename changed 12.01.2005
}
type
   ia=array[0..201]of longint;
   iaa=array[0..201]of ^ia;
   baa=array[0..201,0..201]of byte;
var
   a:iaa;
   previ1,previ2,curi1,curi2:^baa;

   procedure init;
   var
      i,j:integer;
   begin
      for i:=0 to 201 do begin
         new(a[i]);
         for j:=0 to 201 do
            a[i]^[j]:=0;
      end;
      new(previ1);
      new(previ2);
      new(curi1);
      new(curi2);
   end;

   procedure copy(var a,b:iaa);
   var
      i:integer;
   begin
      for i:=0 to 201 do
         b[i]^:=a[i]^;
   end;

   function equal(a1,b1,a2,b2:byte):boolean;
   begin
      equal:=(a1=a2)and(b1=b2);
   end;

   function is0(a,b:byte):boolean;
   begin
      is0:=(a=0)and(b=0);
   end;

var
   n:integer;

   function go:boolean;
   const
      dx:array[1..4]of integer=(1,0,-1,0);
      dy:array[1..4]of integer=(0,1,0,-1);
   var
      i,j,k:integer;
      not0around,diff:boolean;
      v1,v2:byte;
   begin
      go:=false;
      previ1^:=curi1^;
      previ2^:=curi2^;
      for i:=1 to n do
         for j:=1 to n do
            if is0(previ1^[i,j],previ2^[i,j]) then begin
               not0around:=false;
               for k:=1 to 4 do
                  if not is0(previ1^[i+dx[k],j+dy[k]],previ2^[i+dx[k],j+dy[k]]) then begin
                     not0around:=true;
                     v1:=previ1^[i+dx[k],j+dy[k]];
                     v2:=previ2^[i+dx[k],j+dy[k]];
                  end;
               if not not0around then
                  continue;
               go:=true;
               diff:=false;
               for k:=1 to 4 do
                  if not is0(previ1^[i+dx[k],j+dy[k]],previ2^[i+dx[k],j+dy[k]]) and
                     not equal(previ1^[i+dx[k],j+dy[k]],previ2^[i+dx[k],j+dy[k]],v1,v2) then
                        diff:=true;
               if diff then begin
                  curi1^[i,j]:=201;
                  curi2^[i,j]:=201;
               end
               else begin
                  curi1^[i,j]:=v1;
                  curi2^[i,j]:=v2;
               end;
            end;
   end;

   procedure show;
   var
      i,j:integer;
   begin
      for i:=1 to n do begin
         for j:=1 to n do 
            write(a[curi1^[i,j]]^[curi2^[i,j]],' ');
         writeln;
      end;
   end;

var
   i,j:integer;
begin
   assign(input,'nearnum.in');
   reset(input);
   assign(output,'nearnum.out');
   rewrite(output);
   init;
   readln(n);
   for i:=1 to n do begin
      for j:=1 to n do
         read(a[i]^[j]);
      readln;
   end;
   for i:=0 to 201 do
      for j:=0 to 201 do
         if a[i]^[j]=0 then begin
            curi1^[i,j]:=0;
            curi2^[i,j]:=0;
         end
         else begin
            curi1^[i,j]:=i;
            curi2^[i,j]:=j;
         end;
   while go do;
   show;
end.