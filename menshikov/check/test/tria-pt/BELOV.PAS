{$N+,E-}
program d;
const out='TRIA-PT.OUT';
      ins='TRIA-PT.IN';
      eps=1E-18;
type real=extended;
     tVec=record
     x,y:longint;
     end;
     tTria=record
     A,B,C:tVec;
     end;
var f,g:text;
    T:tTria;
    P:tVec;
procedure ReadData(var f:text);
begin
    Assign(f,ins);
    Reset(f);
    readln(f,T.A.x,T.A.y);
    readln(f,T.B.x,T.B.y);
    readln(f,T.C.x,T.C.y);
    readln(f,P.x,P.y);
    Close(f);
end;
function ScalMult(A,B:tVec):real;
begin
    ScalMult:=A.x*B.x+A.y*B.y;
end;
function Absol(A:tVec):real;
begin
    Absol:=sqrt(A.x*A.x+A.y*A.y);
end;
function Arccos(x:real):real;
begin
    if x<=-1 then arccos:=pi;
    if x>=1 then arccos:=0;
    if (x<0)and(x>-1) then arccos:=pi+arctan(sqrt(1-x*x)/x)
    else if(x>0)and(x<1) then arccos:=arctan(sqrt(1-x*x)/x)
    else if x=0 then arccos:=pi/2;
end;
function Angle(A,B:tVec):real;
begin
    Angle:=abs(Arccos(ScalMult(A,B)/(Absol(A)*Absol(B))));
end;
function InSide(T:tTria;P:tVec):boolean;
var S:real;
    PA,PB,PC:tVec;
    a,b,g:real;
    c:real;
begin
    PA.x:=T.A.x-P.x;
    PA.y:=T.A.y-P.y;
    PB.x:=T.B.x-P.x;
    PB.y:=T.B.y-P.y;
    PC.x:=T.C.x-P.x;
    PC.y:=T.C.y-P.y;
    if (Absol(PA)=0)or(Absol(PB)=0)or(Absol(PC)=0)then
       Inside:=true
    else  begin
      a:= Angle(PA,PB);
      b:= Angle(PB,PC);
      g:= Angle(PC,PA);
      c:= 2*pi;
    InSide:=(abs(Angle(PA,PB)+Angle(PB,PC)+Angle(PC,PA)-2*pi)<eps);
    end;
end;
procedure WriteData(var g:text;is:boolean);
begin
    Assign(g,out);
    Rewrite(g);
    if is then write(g,'In')
    else write(g,'Out');
    Close(g);
end;
begin
    ReadData(f);
    WriteData(g,Inside(T,P));
end.