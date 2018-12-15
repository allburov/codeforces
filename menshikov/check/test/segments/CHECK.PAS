{
Written by Fyodor Menshikov 15.12.2002
7:51-8:17
}
{$N+,E-}
type
   real=extended;
   tPoint=record
      x,y:real;
   end;
   tLine=record
      a,b,c:real;
   end;
   tSegment=record
      p1,p2:tPoint;
   end;
   tAnswer=(yes,no);

   procedure ac;
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

   procedure out(answer:tAnswer);
   var
      s:string;
   begin
      assign(input,'segments.out');
      reset(input);
      readln(s);
      if not eof then
         pe;
      if (s<>'Yes')and(s<>'No') then
         pe;
      if (s='Yes')and(answer=yes) then
         ac
      else if (s='No')and(answer=no) then
         ac
      else
         wa;
   end;

   procedure readPoint(var p:tPoint);
   begin
      readln(p.x,p.y);
   end;

   procedure readSegment(var s:tSegment);
   begin
      readPoint(s.p1);
      readPoint(s.p2);
   end;

   procedure segment2line(s:tSegment;var l:tLine);
   begin
      {x-x1/x2-x1=y-y1/y2-y1}
      {x(y2-y1)+y(x1-x2)+(y1-y2)x1+y1(x2-x1)=0}
      l.a:=s.p2.y-s.p1.y;
      l.b:=s.p1.x-s.p2.x;
      l.c:=s.p1.x*(s.p1.y-s.p2.y)+s.p1.y*(s.p2.x-s.p1.x);
   end;

   function sign(n:real):real;
   begin
      if n>0 then
         sign:=1
      else if n<0 then
         sign:=-1
      else
         sign:=0;
   end;

   function pointSign(l:tLine;p:tPoint):real;
   begin
      pointSign:=sign(l.a*p.x+l.b*p.y+l.c);
   end;

   function between(test,value1,value2:real):boolean;
   begin
      if value1<value2 then
         between:=(value1<=test)and(test<=value2)
      else if value2<value1 then
         between:=(value2<=test)and(test<=value1)
      else
         halt(1);
   end;

   function onSegment(p:tPoint;s:tSegment):boolean;
   begin
      if s.p1.x=s.p2.x then
         onSegment:=between(p.y,s.p1.y,s.p2.y)
      else
         onSegment:=between(p.x,s.p1.x,s.p2.x);
   end;

   procedure printPoint(p:tPoint);
   begin
      writeln('Point: (',p.x:0:0,',',p.y:0:0,')');
   end;

   procedure printSegment(s:tSegment;name:string);
   begin
      writeln('Segment start:');
      printPoint(s.p1);
      writeln('Segment end:');
      printPoint(s.p2);
   end;

   procedure printLine(l:tLine);
   begin
      writeln('Line a=',l.a:0:0,' b=',l.b:0:0,' c=',l.c:0:0);
   end;

var
   s1,s2:tSegment;
   l1,l2:tLine;
begin
   assign(input,'segments.in');
   reset(input);
   readSegment(s1);
   readSegment(s2);
   segment2line(s1,l1);
   if (pointSign(l1,s2.p1)=0)and(pointSign(l1,s2.p2)=0) then
      {one line}
   else begin
      if pointSign(l1,s2.p1)=pointSign(l1,s2.p2) then
         out(no);
      segment2line(s2,l2);
      if pointSign(l2,s1.p1)=pointSign(l2,s1.p2) then
         out(no);
      out(yes);
   end;
   if onSegment(s1.p1,s2) 
   or onSegment(s1.p2,s2)
   or onSegment(s2.p1,s1)
   or onSegment(s2.p2,s1)
   then
      out(yes)
   else
      out(no);
end.