{
Written by Fyodor Menshikov 19.04.2002
13:14-13:20
I/O filename changed 11.01.2004
}
{$M 65520,0,655360}
var
   n:integer;

   procedure show(chisl_left,znam_left,chisl_right,znam_right:integer);
   var
      chisl,znam:integer;
   begin
      chisl:=chisl_left+chisl_right;
      znam:=znam_left+znam_right;
      if znam<=n then begin
         show(chisl_left,znam_left,chisl,znam);
         writeln(chisl,'/',znam);
         show(chisl,znam,chisl_right,znam_right);
      end;
   end;

begin
   assign(input,'ordfrac.in');
   reset(input);
   readln(n);
   close(input);
   assign(output,'ordfrac.out');
   rewrite(output);
   show(0,1,1,1);
   close(output);
end.