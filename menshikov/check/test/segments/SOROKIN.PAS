{$N+,E-,Q+,R+,S+}
program segments;
const
   name='segments';
   alfa=Pi/90;
   eps=1e-10;
var
   i,j:integer;
   x,y,x1,x2,x3,x4,y1,y2,y3,y4,k1,k2,b1,b2,t:extended;

procedure load;
begin
   assign(input,name+'.in');
   reset(input);
   assign(output,name+'.out');
   rewrite(output);
   readln(x1,y1);
   readln(x2,y2);
   readln(x3,y3);
   readln(x4,y4);
   x:=x1*cos(alfa)-y1*sin(alfa);
   y:=y1*cos(alfa)+x1*sin(alfa);
   x1:=x;
   y1:=y;

   x:=x2*cos(alfa)-y2*sin(alfa);
   y:=y2*cos(alfa)+x2*sin(alfa);
   x2:=x;
   y2:=y;

   x:=x3*cos(alfa)-y3*sin(alfa);
   y:=y3*cos(alfa)+x3*sin(alfa);
   x3:=x;
   y3:=y;

   x:=x4*cos(alfa)-y4*sin(alfa);
   y:=y4*cos(alfa)+x4*sin(alfa);
   x4:=x;
   y4:=y;

   if (x1>x2)then begin
      t:=x2;
      x2:=x1;
      x1:=t;
      t:=y2;
      y2:=y1;
      y1:=t;
   end;
   if (x3>x4)then begin
      t:=x4;
      x4:=x3;
      x3:=t;
      t:=y4;
      y4:=y3;
      y3:=t;
   end;
end;

begin
   load;
   k1:=(y2-y1)/(x2-x1);
   b1:=y1-x1*(y2-y1)/(x2-x1);
   k2:=(y4-y3)/(x4-x3);
   b2:=y3-x3*(y4-y3)/(x4-x3);
   if abs(k1-k2)<=eps then begin
      if abs(b1-b2)>eps then begin
         writeln('No');
         halt(0);
      end;
      if x3>=x2 then begin
         if (x3-x2)>=eps then begin
            writeln('No');
            halt(0);
         end;
         if abs(x3-x2)<=eps then begin
            writeln('Yes');
            halt(0);
         end else begin
            writeln('No');
            halt(0);
         end;
      end;
      if x3=x2 then begin
         writeln('Yes');
         halt(0);
      end;
      {x3<x2}
      if ((x1-x4)<=eps)and(x4-x1>=-eps) then begin
         writeln('Yes');
         halt(0);
      end else begin
         writeln('No');
         halt(0);
      end;
   end;
   x:=(b2-b1)/(k1-k2);
   y:=k1*x+b1;

   if ((x-x1)>=-eps)and((x2-x)>=-eps)then begin
      if ((y1>=y)and(y2<=y))or
         ((y1<=y)and(y2>=y))then begin
         if ((x-x3)>=-eps)and((x4-x)>=-eps)then begin
            if ((y3>=y)and(y4<=y))or
               ((y3<=y)and(y4>=y))then
                  writeln('Yes')
            else
               writeln('No');
         end
         else
            writeln('No');
      end else
         writeln('No');
   end
   else
      writeln('No');
end.