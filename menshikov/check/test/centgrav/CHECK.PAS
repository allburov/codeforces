{
Written by Fyodor Menshikov 16.08.2004
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

var
   c:char;

   procedure nextChar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
   end;

   procedure fixed2(var r:real);
   var
      minus:boolean;
   begin
      if c='-' then begin
         minus:=true;
         nextChar;
      end
      else
         minus:=false;
      if c='0' then begin
         if minus then
            pe(1);
         r:=0;
         nextChar;
      end
      else if c in ['1'..'9'] then begin
         r:=ord(c)-ord('0');
         nextChar;
         while c in ['0'..'9'] do begin
            r:=r*10+ord(c)-ord('0');
            if r>1e6 then
               r:=1e6;
            nextChar;
         end;
      end
      else
         pe(2);
      if c<>'.' then
         pe(3);
      nextChar;
      if not (c in ['0'..'9']) then
         pe(4);
      r:=r*10+ord(c)-ord('0');
      nextChar;
      if not (c in ['0'..'9']) then
         pe(5);
      r:=r*10+ord(c)-ord('0');
      nextChar;
      r:=r/100;
      if minus then
         r:=-r;
   end;

var
   userX,userY,judgeX,judgeY:real;
begin
   assign(input,'centgrav.out');
   reset(input);
   nextChar;
   fixed2(userX);
   if c<>' ' then
      pe(6);
   nextChar;
   fixed2(userY);
   if c<>#13 then
      pe(7);
   readln;
   if not eof then
      pe(8);
   assign(input,'centgrav.chk');
   reset(input);
   readln(judgeX,judgeY);
   if (abs(userX-judgeX)>0.011) or (abs(userY-judgeY)>0.011) then
      wa
   else
      ac;
end.