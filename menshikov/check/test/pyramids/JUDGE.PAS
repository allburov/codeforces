{
Written by Fyodor Menshikov 17.09.2003
1:35-1:44
}
{$N+,E-}
type
   real=extended;
   point=record
      x,y,z:real;
   end;
var
   a,b,c,d:point;
   ab,ac,ad,bc,bd,cd:real;
begin
   assign(input,'pyramids.in');
   reset(input);
   assign(output,'pyramids.out');
   rewrite(output);
   readln(ab,ac,ad,bc,bd,cd);

   {A is at (0,0,0)}
   {B is at 0x}
   b.x:=ab;
   {C is at x0y}
   c.x:=(ac*ac+ab*ab-bc*bc)/(2*ab);
   c.y:=sqrt(ac*ac-c.x*c.x);
   {D is in 3D space}
   d.x:=(ad*ad+ab*ab-bd*bd)/(2*ab);
   d.y:=(ad*ad+c.x*c.x+c.y*c.y-2*c.x*d.x-cd*cd)/(2*c.y);
   d.z:=sqrt(ad*ad-d.x*d.x-d.y*d.y);

   writeln(b.x*c.y*d.z/6:0:4);
end.