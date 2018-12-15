{
Written by Fyodor Menshikov 22.08.2004
19:26-19:52 (+2)
}
{$M 65520,0,655360}
type
   data=array['A'..'Z','a'..'{']of integer;

   procedure clear(var d:data);
   var
      c1,c2:char;
   begin
      for c1:='A' to 'Z' do
         for c2:='a' to '{' do
            d[c1,c2]:=0;
   end;

   procedure mul(var d:data;n:integer);
   var
      c1,c2:char;
   begin
      for c1:='A' to 'Z' do
         for c2:='a' to '{' do
            d[c1,c2]:=d[c1,c2]*n;
   end;

   procedure add(var d1,d2:data);
   var
      c1,c2:char;
   begin
      for c1:='A' to 'Z' do
         for c2:='a' to '{' do
            d1[c1,c2]:=d1[c1,c2]+d2[c1,c2];
   end;

   function eq(var d1,d2:data):boolean;
   var
      c1,c2:char;
   begin
      eq:=false;
      for c1:='A' to 'Z' do
         for c2:='a' to '{' do
            if d1[c1,c2]<>d2[c1,c2] then
               exit;
      eq:=true;
   end;

   procedure ie(id:string);
   begin
      writeln('internal error: ',id);
      halt(1);
   end;

var
   s:string;
   pos:integer;
   c:char;
   
   procedure nextChar;
   begin
      inc(pos);
      if pos<=length(s) then begin
         c:=s[pos];
         {write(c);}
      end
      else begin
         c:=#13;
         dec(pos);
      end;
   end;

   procedure numberopt(var n:integer);
   begin
      if c in ['1'..'9'] then begin
         n:=0;
         while c in ['0'..'9'] do begin
            n:=n*10+ord(c)-ord('0');{no check}
            nextChar;
         end;
      end
      else
         n:=1;
   end;

   procedure chem(var d:data);
   var
      c1,c2:char;
   begin
      if c in ['A'..'Z'] then begin
         c1:=c;
         nextChar;
      end
      else
         ie('chem');
      if c in ['a'..'z'] then begin
         c2:=c;
         nextChar;
      end
      else
         c2:='{';
      clear(d);
      d[c1,c2]:=1;
   end;

   procedure sequence(var d:data);forward;

   procedure elem(var d:data);
   begin
      if c in ['A'..'Z'] then
         chem(d)
      else if c='(' then begin
         nextChar;
         sequence(d);
         if c=')' then
            nextChar
         else
            ie('elem1');
      end
      else
         ie('elem2');
   end;

   procedure sequence(var d:data);
   var
      m:integer;
      d2:^data;
   begin
      elem(d);
      numberopt(m);
      mul(d,m);
      while c in ['A'..'Z','('] do begin
         new(d2);
         elem(d2^);
         numberopt(m);
         mul(d2^,m);
         add(d,d2^);
         dispose(d2);
      end;
   end;

   procedure formula(var d:data);
   var
      m:integer;
      d2:^data;
   begin
      numberopt(m);
      sequence(d);
      mul(d,m);
      while c='+' do begin
         nextChar;
         numberopt(m);
         new(d2);
         sequence(d2^);
         mul(d2^,m);
         add(d,d2^);
         dispose(d2);
      end;
   end;

   procedure parse(s0:string;var d:data);
   begin
      s:=s0;
      pos:=0;
      nextChar;
      formula(d);
      if c<>#13 then
         ie('parse');
   end;

var
   left,right:string;
   i,n:integer;
   ldata,rdata:data;
begin
   assign(input,'chem.in');
   reset(input);
   assign(output,'chem.out');
   rewrite(output);
   readln(left);
   parse(left,ldata);
   readln(n);
   for i:=1 to n do begin
      readln(right);
      parse(right,rdata);
      if eq(ldata,rdata) then
         writeln(left,'==',right)
      else
         writeln(left,'!=',right);
   end;
end.