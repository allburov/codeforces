{
Written by Fyodor Menshikov 17.04.2002
22:47-22:58
}
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
   assign(output,'birthday.out');
   rewrite(output);
   writeln(last);
   close(output);
end.