{
Written by Fyodor Menshikov 04.04.2004
11:24-12:04
}
const
   maxn=70000;
type
   qq=array[0..14999]of longint;
var
   a:array[0..4]of ^qq;

   procedure put(index,value:longint);
   begin
      a[index div 15000]^[index mod 15000]:=value;
   end;

   function get(index:longint):longint;
   begin
      get:=a[index div 15000]^[index mod 15000];
   end;

   procedure swap(i1,i2:longint);
   var
      v1,v2:longint;
   begin
      v1:=get(i1);
      v2:=get(i2);
      put(i1,v2);
      put(i2,v1);
   end;

var
   n,i,left,right,mid:longint;
begin
   for i:=0 to 4 do
      new(a[i]);
   assign(input,'antiqs.in');
   reset(input);
   assign(output,'antiqs.out');
   rewrite(output);
   readln(n);
   left:=1;
   right:=n;
   for i:=1 to n do
      put(i,i);
   for i:=3 to n do begin
      swap((1+i)div 2,i);
   end;
   for i:=1 to n do
      write(get(i),' ');
end.