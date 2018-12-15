{
Written by Fyodor Menshikov 24.10.2004
10:23-11:20
}
   procedure ie(message:string);
   begin
      writeln('internal error: ',message);
      halt(1);
   end;

const
   maxint=maxlongint;
   minint=-maxint-1;
type
   integer=longint;
   TPoly=array[0..20]of integer;

   procedure init(var p:TPoly);
   var
      i:integer;
   begin
      for i:=low(p) to high(p) do
         p[i]:=0;
   end;

   procedure add(var n1:integer;n2:integer);
   begin
      if (n1>0) and (n2>0) and (n1>maxint-n2) then
         ie('add1');
      if (n1<0) and (n2<0) and (n1<minint-n2) then
         ie('add2');
      n1:=n1+n2;
   end;

   procedure mul(n1,n2:integer;var n3:integer);
   begin
      n3:=1;
      if n1<0 then begin
         n1:=-n1;
         n3:=-n3;
      end;
      if n2<0 then begin
         n2:=-n2;
         n3:=-n3;
      end;
      if (n2>0) and (n1>maxint div n2) then
         ie('mul');
      n3:=n3*n1*n2;
   end;

var
   c:char;

   procedure nextChar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
   end;



   procedure number(var n:integer);
   var
      digit:integer;
   begin
      if c='0' then begin
         n:=0;
         nextChar;
      end
      else if c in ['1'..'9'] then begin
         n:=0;
         while c in ['0'..'9'] do begin
            digit:=ord(c)-ord('0');
            if n<=10000 then
               n:=n*10+digit
            else
               ie('number1');
            nextChar;
         end;
      end
      else
         ie('number2');
   end;

   procedure power(var pow:integer);
   begin
      if c='^' then begin
         nextChar;
         number(pow);
         if pow<=1 then
            ie('power');
      end
      else
         pow:=1;
   end;

   procedure mono(var p:TPoly;sign:integer);
   var
      koef,pow:integer;
   begin
      if c='x' then begin
         koef:=1;
         nextChar;
         power(pow);
      end
      else begin
         number(koef);
         if c='x' then begin
            if (koef=0) or (koef=1) then
               ie('mono1');
            nextChar;
            power(pow);
         end
         else
            pow:=0;
      end;
      if koef>10000 then
         ie('mono2');
      if pow>10 then
         ie('mono3');
      add(p[pow],sign*koef);
   end;

   procedure load(var p:TPoly);
   var
      sign:integer;
   begin
      init(p);
      nextChar;
      sign:=1;
      if c='-' then begin
         nextChar;
         sign:=-1;
      end;
      mono(p,sign);
      while true do begin
         if c='+' then begin
            nextChar;
            sign:=1;
         end
         else if c='-' then begin
            nextChar;
            sign:=-1;
         end
         else if c=#13 then
            break
         else
            ie('load');
         mono(p,sign);
      end;
      readln;
   end;

   procedure polymul(p1,p2:TPoly;var p3:TPoly);
   var
      i1,i2,i3,t:integer;
   begin
      init(p3);
      for i1:=low(p1) to high(p1) do
         for i2:=low(p2) to high(p2) do begin
            i3:=i1+i2;
            mul(p1[i1],p2[i2],t);
            if (t<>0) and (i3>high(p3)) then
               ie('polymul');
            add(p3[i3],t);
         end;
   end;

   procedure printMono(koef,pow:integer);
   begin
      if koef<=0 then
         ie('printMono');
      if pow=0 then
         write(koef)
      else begin
         if koef<>1 then
            write(koef);
         write('x');
         if pow<>1 then
            write('^',pow);
      end;
   end;

   procedure print(var p:TPoly);
   var
      i:integer;
   begin
      i:=high(p);
      while (i>0) and (p[i]=0) do
         dec(i);

      if p[i]=0 then begin
         write(0)
      end
      else if p[i]>0 then begin
         printMono(p[i],i);
      end
      else if p[i]<0 then begin
         write('-');
         printMono(-p[i],i);
      end
      else
         ie('print1');

      for i:=i-1 downto 0 do begin
         if p[i]=0 then
            {nothing}
         else if p[i]>0 then begin
            write('+');
            printMono(p[i],i);
         end
         else if p[i]<0 then begin
            write('-');
            printMono(-p[i],i);
         end
         else
            ie('print2');
      end;
      writeln;
   end;

var
   p1,p2,p3:TPoly;
begin
   assign(input,'polymul.in');
   reset(input);
   assign(output,'polymul.out');
   rewrite(output);
   load(p1);
   {print(p1);}
   load(p2);
   {print(p2);}
   polymul(p1,p2,p3);
   print(p3);
end.