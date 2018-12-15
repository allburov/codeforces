{
Written by Fyodor Menshikov 29.07.2002
8:10-8:17
I/O filename changed 11.01.2004
}
{$M 65520,0,0}
var
   a:array[0..101,0..101]of boolean;
   m,n,s:integer;
   ii,jj:integer;

   procedure remove;
   begin
      if a[ii,jj] then begin
         a[ii,jj]:=false;

         inc(ii);
         remove;
         dec(ii);

         dec(ii);
         remove;
         inc(ii);

         inc(jj);
         remove;
         dec(jj);

         dec(jj);
         remove;
         inc(jj);
      end;
   end;

var
   c:char;
   i,j:integer;
begin
   assign(input,'remsquar.in');
   reset(input);
   readln(m,n);
   for i:=0 to m+1 do
      for j:=0 to n+1 do
         a[i,j]:=false;
   for i:=1 to m do begin
      for j:=1 to n do begin
         read(c);
         case c of
         '#':a[i,j]:=true;
         '.':a[i,j]:=false;
         else
            halt(1);
         end;
      end;
      readln;
   end;
   s:=0;
   for i:=1 to m do
      for j:=1 to n do
         if a[i,j] then begin
            ii:=i;
            jj:=j;
            remove;
            inc(s);
         end;
   assign(output,'remsquar.out');
   rewrite(output);
   writeln(s);
end.