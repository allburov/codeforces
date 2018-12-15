{
Written by Fyodor Menshikov 22.12.2003
21:34-21:38
Modified into check 22.12.2003
}
{$N+,E-}
type
   integer=longint;
   real=extended;

   procedure ac;
   begin
      writeln('a');
      halt(0);
   end;

   procedure wa;
   begin
      writeln('wa');
      halt(1);
   end;

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

var
   c:char;

   procedure nextchar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
   end;

   procedure check(judgeanswer:real);
   var
      useranswer:real;
   begin
      assign(input,'area.out');
      reset(input);
      nextchar;
      if c='0' then begin
         nextchar;
      end
      else if c in ['1'..'9'] then begin
         repeat
            nextchar;
         until not (c in ['0'..'9']);
      end
      else
         pe;
      {now must be '.'}
      if c<>'.' then
         pe;
      nextchar;
      if not (c in ['0'..'9']) then
         pe;
      nextchar;
      if c<>#13 then
         pe;
      readln;
      if not eof then
         pe;
      reset(input);
      {$I-}{does this affect reading of reals?}
      readln(useranswer);
      {$I+}
      if ioresult<>0 then
         wa;{not pe, number look is correct}
      {can compare real numbers, they are exact}
      if useranswer<>judgeanswer then
         wa;
      ac;
   end;

var
   n,i:integer;
   x0,y0,x1,y1,x2,y2,s:real;
begin
   assign(input,'area.in');
   reset(input);
   readln(n);
   readln(x0,y0);
   x1:=x0;
   y1:=y0;
   s:=0;
   for i:=2 to n do begin
      x2:=x1;
      y2:=y1;
      readln(x1,y1);
      s:=s+(x1-x2)*(y1+y2);
   end;
   x2:=x1;
   y2:=y1;
   x1:=x0;
   y1:=y0;
   s:=s+(x1-x2)*(y1+y2);
   check(abs(s)/2);
end.