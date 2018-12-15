{
Written by Fyodor Menshikov 07.09.2002
I/O file name changed 17.11.2003
}
{$R+}
   procedure a;
   begin
      writeln('a');
      halt(0);
   end;

   procedure wa;
   begin
      writeln('wa');
      halt(1);
   end;

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

const
   ans:array[1..2]of string=('In','Out');
   _In=1;
   _Out=2;

   procedure check(index:integer);
   var
      answer:string;
      i:integer;
   begin
      assign(input,'tria-pt.out');
      reset(input);
      readln(answer);
      if not eof then
         pe;
      for i:=low(ans) to high(ans) do
         if ans[i]=answer then begin
            if i=index then
               a
            else
               wa;
         end;
      pe;
   end;

type
   tpoint=record
      x,y:longint;
   end;
   tline=record
      a,b,c:longint;
   end;

   procedure getLine(p1,p2:tpoint;var l:tline);
   begin
      l.a:=p2.y-p1.y;
      l.b:=p1.x-p2.x;
      l.c:=p1.y*(p2.x-p1.x)-p1.x*(p2.y-p1.y);
   end;

   function lineValue(l:tline;p:tpoint):longint;
   begin
      lineValue:=l.a*p.x+l.b*p.y+l.c;
   end;

   function equalSign(x,y:longint):boolean;
   begin
      if (x=0)or(y=0) then
         equalSign:=true
      else if (x>0)and(y>0) then
         equalSign:=true
      else if (x<0)and(y<0) then
         equalSign:=true
      else
         equalSign:=false;
   end;

   procedure readPoint(var p:tpoint);
   begin
      readln(p.x,p.y);
   end;

var
   t1,t2,t3:tpoint;
   p:tpoint;
   l1,l2,l3:tline;
   side1,side2,side3:boolean;
begin
   assign(input,'tria-pt.in');
   reset(input);
   readPoint(t1);
   readPoint(t2);
   readPoint(t3);
   readPoint(p);

   getLine(t1,t2,l3);
   getLine(t1,t3,l2);
   getLine(t2,t3,l1);
   side1:=equalSign(lineValue(l1,t1),lineValue(l1,p));
   side2:=equalSign(lineValue(l2,t2),lineValue(l2,p));
   side3:=equalSign(lineValue(l3,t3),lineValue(l3,p));

   if side1 and side2 and side3 then
      check(_In)
   else
      check(_Out);
end.
