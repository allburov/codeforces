{
Written by Fyodor Menshikov 17.04.2002
22:47-22:58
Modified into checker 30.12.2003
}
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

   procedure check(judgeanswer:integer);
   var
      useranswer:longint;
      d:integer;
   begin
      assign(input,'birthday.out');
      reset(input);
      useranswer:=0;
      nextchar;
      if c='0' then begin
         nextchar;
      end
      else if c in ['1'..'9'] then begin
         while c in ['0'..'9'] do begin
            d:=ord(c)-ord('0');
            if useranswer<1000000 then
               useranswer:=useranswer*10+d;{else it is already wrong}
            nextchar;
         end;
      end
      else
         pe;
      if c<>#13 then
         pe;
      readln;
      if not eof then
         pe;
      if useranswer<>judgeanswer then
         wa;
      ac;
   end;

type
   tdate=record
      day,month,year:integer;
   end;

   function eqdaymonth(d1,d2:tdate):boolean;
   begin
      eqdaymonth:=(d1.day=d2.day)and(d1.month=d2.month);
   end;

   procedure nextday(var date:tdate);
   var
      daysinmonth:integer;
   begin
      case date.month of
      1,3,5,7,8,10,12:daysinmonth:=31;
      4,6,9,11:daysinmonth:=30;
      2:begin
         if (date.year mod 400=0)or(date.year mod 4=0)and(date.year mod 100<>0) then
            daysinmonth:=29
         else
            daysinmonth:=28;
      end;
      else
         halt(1);
      end;
      if date.day<daysinmonth then begin
         inc(date.day);
         exit;
      end;
      date.day:=1;
      inc(date.month);
      if date.month=13 then begin
         date.month:=1;
         inc(date.year);
      end;
   end;

var
   cur,bir:tdate;
   last:integer;
begin
   assign(input,'birthday.in');
   reset(input);
   readln(bir.day,bir.month);
   readln(cur.day,cur.month,cur.year);
   close(input);
   last:=0;
   while not eqdaymonth(cur,bir) do begin
      nextday(cur);
      inc(last);
   end;
   check(last);
end.