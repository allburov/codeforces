{
Written by Fyodor Menshikov 17.05.2002
15:01-15:44
}
const
   wall=1;
   space=2;
   origin=3;
   way=4;
   p1_0=5;
   m1_0=6;
   _0p1=7;
   _0m1=8;
type
   queue=array[1..250*250]of byte;
var
   qx,qy:^queue;
   first,last:word;

   procedure add_queue(x,y:byte);
   begin
      inc(last);
      qx^[last]:=x;
      qy^[last]:=y;
   end;

   procedure get_queue(var x,y:byte);
   begin
      x:=qx^[first];
      y:=qy^[first];
      inc(first);
   end;

   function not_empty:boolean;
   begin
      not_empty:=first<=last;
   end;

var
   n:integer;
   a:array[0..251,0..251]of byte;
   destx,desty:integer;

   procedure read_data;
   var
      i,j:integer;
      c:char;
   begin
      assign(input,'lines2.in');
      reset(input);
      readln(n);
      for i:=0 to n+1 do
         for j:=0 to n+1 do
            a[i,j]:=wall;
      for i:=1 to n do begin
         for j:=1 to n do begin
            read(c);
            case c of
            '.':a[i,j]:=space;
            'O':a[i,j]:=wall;
            '@':begin
               a[i,j]:=origin;
               add_queue(i,j);
            end;
            'X':begin
               a[i,j]:=space;
               destx:=i;
               desty:=j;
            end;
            else
               halt(1);
            end;
         end;
         readln;
      end;
   end;

   procedure first_step;
   var
      x,y:byte;
   begin
      while not_empty do begin
         get_queue(x,y);
         if a[x+1,y]=space then begin
            a[x+1,y]:=p1_0;
            add_queue(x+1,y);
         end;
         if a[x-1,y]=space then begin
            a[x-1,y]:=m1_0;
            add_queue(x-1,y);
         end;
         if a[x,y+1]=space then begin
            a[x,y+1]:=_0p1;
            add_queue(x,y+1);
         end;
         if a[x,y-1]=space then begin
            a[x,y-1]:=_0m1;
            add_queue(x,y-1);
         end;
      end;
   end;

var
   possible:boolean;
   waylen:longint;

   procedure second_step;
   var
      x,y:byte;
   begin
      if a[destx,desty]=space then
         possible:=false
      else begin
         possible:=true;
         waylen:=0;
         while true do begin
            case a[destx,desty] of
            p1_0:begin
               a[destx,desty]:=way;
               destx:=destx-1;
            end;
            m1_0:begin
               a[destx,desty]:=way;
               destx:=destx+1;
            end;
            _0p1:begin
               a[destx,desty]:=way;
               desty:=desty-1;
            end;
            _0m1:begin
               a[destx,desty]:=way;
               desty:=desty+1;
            end;
            origin:
               break;
            else
               halt(2);
            end;
            inc(waylen);
         end;
      end;
      for x:=1 to n do
         for y:=1 to n do
            case a[x,y] of
            p1_0,m1_0,_0p1,_0m1:a[x,y]:=space;
            end;
   end;

   procedure output_data;
   var
      i,j:integer;
   begin
      assign(output,'lines2.out');
      rewrite(output);
      if not possible then
         writeln('N')
      else begin
         writeln('Y');
         for i:=1 to n do begin
            for j:=1 to n do
               case a[i,j] of
               origin:write('@');
               wall:write('O');
               way:write('+');
               space:write('.');
               else
                  halt(3);
               end;
            writeln;
         end;
      end;
   end;

begin
   new(qx);
   new(qy);
   first:=1;
   last:=0;
   read_data;
   first_step;
   second_step;
   output_data;
end.