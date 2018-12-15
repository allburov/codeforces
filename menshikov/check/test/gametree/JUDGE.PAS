{
Written by Fyodor Menshikov 22.11.2003
10:13-10:24
}
var
   n:integer;
   a:array[1..1000]of record
      isLeaf:boolean;
      parent:integer;
      leafResult:integer;
   end;

   procedure load;
   var
      c:char;
      i:integer;
   begin
      readln(n);
      a[1].isLeaf:=false;
      a[1].parent:=-1;
      a[1].leafResult:=100;
      for i:=2 to n do begin
         read(c);
         if c='N' then begin
            a[i].isLeaf:=false;
            readln(a[i].parent);
         end
         else if c='L' then begin
            a[i].isLeaf:=true;
            readln(a[i].parent,a[i].leafResult);
         end
         else
            halt(1);
      end;
   end;

   function best1(node:integer):integer;forward;
   function best2(node:integer):integer;forward;

   function best1(node:integer):integer;
   var
      max,i,t:integer;
   begin
      if a[node].isLeaf then
         best1:=a[node].leafResult
      else begin
         max:=-1;
         for i:=1 to n do
            if a[i].parent=node then begin
               t:=best2(i);
               if t>max then
                  max:=t;
            end;
         best1:=max;
      end;
   end;

   function best2(node:integer):integer;
   var
      min,i,t:integer;
   begin
      if a[node].isLeaf then
         best2:=a[node].leafResult
      else begin
         min:=1;
         for i:=1 to n do
            if a[i].parent=node then begin
               t:=best1(i);
               if t<min then
                  min:=t;
            end;
         best2:=min;
      end;
   end;

   procedure show(result:integer);
   begin
      if result=1 then
         writeln('+1')
      else if result=0 then
         writeln('0')
      else if result=-1 then
         writeln('-1')
      else
         halt(1);
   end;

begin
   assign(input,'gametree.in');
   reset(input);
   assign(output,'gametree.out');
   rewrite(output);
   load;
   show(best1(1));
end.