{
Written by Fyodor Menshikov 13.01.2004
8:57-9:09
bug fixed at 9:40 (wrong formula for equal ends)
bug fixed at 10:48 (TP coprocessor stack bug)
I/O filename changed 21.01.2005
}
{$N+,E-}
{$R+,Q+}
   procedure ie(message:string);
   begin
      writeln('Internal error: ',message);
      halt(1);
   end;

   procedure check(s:string);
   var
      i:integer;
   begin
      if (length(s)<1) or (length(s)>60) then
         ie('invalid string length');
      for i:=1 to length(s) do
         if not(s[i] in ['A'..'Z']) then
            ie('invalid character in string');
   end;

var
   a:array[1..60,1..60]of comp;
   s:string;

   procedure initTable;
   var
      i,j:integer;
   begin
      for i:=1 to 60 do
         for j:=1 to 60 do
            a[i,j]:=0;
   end;

   function get(start,finish:integer):comp;
   var
      result,t:comp;
   begin
      if a[start,finish]<>0 then begin
         get:=a[start,finish];
         exit;
      end;
      if start=finish+1 then
         result:=0
      else if start>finish then
         ie('start>finish+1')
      else if start=finish then
         result:=1{one non-empty}
      else if s[start]<>s[finish] then begin
         result:=0;
         t:=get(start+1,finish);
         result:=result+t;
         t:=get(start,finish-1);
         result:=result+t;
         t:=get(start+1,finish-1);
         result:=result-t;
      end
      else begin
         result:=0;
         t:=get(start+1,finish);
         result:=result+t;
         t:=get(start,finish-1);
         result:=result+t;
         result:=result+1;
      end;
      a[start,finish]:=result;
      get:=result;
   end;

begin
   assign(input,'palindr.in');
   reset(input);
   assign(output,'palindr.out');
   rewrite(output);
   readln(s);
   check(s);
   initTable;
   writeln(get(1,length(s)):0:0);
end.