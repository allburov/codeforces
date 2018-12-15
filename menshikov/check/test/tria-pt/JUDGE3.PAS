{
Written by Fyodor Menshikov 29.03.2004
12:14-12:24 (+2) debugged by 12:29
Idea by Ekaterina Grozina
}
{$R+,Q+}
{$N+,E-}
type
   integer=longint;
   real=double;
   tPoint=record
      x,y:integer;
   end;
   tVector=record
      x,y:integer;
   end;

   procedure readPoint(var p:tPoint);
   begin
      readln(p.x,p.y);
   end;

   function equalPoint(p1,p2:tPoint):boolean;
   begin
      equalPoint:=(p1.x=p2.x)and(p1.y=p2.y);
   end;

   procedure newVector(p1,p2:tPoint;var v:tVector);
   begin
      v.x:=p2.x-p1.x;
      v.y:=p2.y-p1.y;
   end;

   function len(v:tVector):real;
   begin
      len:=sqrt(sqr(v.x)+sqr(v.y));
   end;

   function scalarProduct(v1,v2:tVector):integer;
   begin
      scalarProduct:=v1.x*v2.x+v1.y*v2.y;
   end;

   function cos(v1,v2:tVector):real;
   begin
      cos:=scalarProduct(v1,v2)/(len(v1)*len(v2));
   end;

   function inAngle(v1,v2,vx:tVector):boolean;
   begin
      inAngle:=(cos(v1,vx)>=cos(v1,v2)) and (cos(v2,vx)>=cos(v2,v1));
   end;

var
   A,B,C,X:tPoint;
   AB,BA,AC,CA,BC,CB,AX,BX,CX:tVector;
begin
   assign(input,'tria-pt.in');
   reset(input);
   assign(output,'tria-pt.out');
   rewrite(output);
   readPoint(A);
   readPoint(B);
   readPoint(C);
   readPoint(X);
   newVector(A,B,AB);
   newVector(B,A,BA);
   newVector(A,C,AC);
   newVector(C,A,CA);
   newVector(B,C,BC);
   newVector(C,B,CB);
   newVector(A,X,AX);
   newVector(B,X,BX);
   newVector(C,X,CX);
   if equalPoint(A,X) or equalPoint(B,X) or equalPoint(C,X) then
      writeln('In')
   else if inAngle(AB,AC,AX) and inAngle(BA,BC,BX) and inAngle(CA,CB,CX) then
      writeln('In')
   else
      writeln('Out');
end.