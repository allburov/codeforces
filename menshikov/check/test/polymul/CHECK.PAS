{
Written by Fyodor Menshikov 24.10.2004
}
   procedure ac;
   begin
      writeln('a');
      halt;
   end;

   procedure wa;
   begin
      writeln('wa');
      halt(1);
   end;

   procedure pe(id:integer);
   begin
      writeln('pe'{,id});
      halt(2);
   end;

   procedure ie(message:string);
   begin
      writeln('Internal error: ',message);
      while true do;
   end;

type
   integer=longint;
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
      d:integer;
   begin
      if c='0' then begin
         nextChar;
         n:=0;
      end
      else if c in ['1'..'9'] then begin
         n:=0;
         while c in ['0'..'9'] do begin
            d:=ord(c)-ord('0');
            if n<=100000000 then
               n:=n*10+d;
            {else no error}
            nextChar;
         end;
      end
      else
         pe(1);
   end;

   procedure power(var p:integer);
   begin
      if c='^' then begin
         nextChar;
         number(p);
         if p<=1 then
            pe(2);
      end
      else
         p:=1;
   end;

   procedure mono(sign:char;var oldPow:integer);
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
            nextChar;
            power(pow);
         end
         else
            pow:=0;
         if (koef=0) and not ((pow=0) and (sign=' ')) then
            pe(3);
         if (koef=1) and (pow<>0) then
            pe(4);
      end;
      if pow>=oldPow then
         pe(5);
      oldPow:=pow;
   end;

   procedure poly;
   var
      sign:char;
      pow:integer;
   begin
      sign:=' ';
      if c='-' then begin
         sign:='-';
         nextChar;
      end;
      pow:=21;
      mono(sign,pow);
      while c in ['+','-'] do begin
         sign:=c;
         nextChar;
         mono(sign,pow);
      end;
   end;

var
   ua,ja:string;
begin
   assign(input,'polymul.out');
   reset(input);
   nextChar;
   poly;
   if c<>#13 then
      pe(6);
   readln;
   if not eof then
      pe(7);
   reset(input);
   readln(ua);
   assign(input,'polymul.chk');
   reset(input);
   readln(ja);
   if ua<>ja then
      wa;
   ac;
end.