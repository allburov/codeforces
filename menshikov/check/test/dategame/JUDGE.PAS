{
Written by Fyodor Menshikov 05.01.2003
12:08-12:16
}
const
   dim:array[1..12]of integer=(31,29,31,30,31,30,31,31,30,31,30,31);
var
   wins:array[1..31,1..12]of boolean;

   function isCorrect(day,month:integer):boolean;
   begin
      isCorrect:=(1<=month)and(month<=12)and(1<=day)and(day<=dim[month]);
   end;

   function doesWin(day,month:integer):boolean;
   begin
      doesWin:=false;
      if isCorrect(day+1,month) then
         if not wins[day+1,month] then
            doesWin:=true;
      if isCorrect(day+2,month) then
         if not wins[day+2,month] then
            doesWin:=true;
      if isCorrect(day,month+1) then
         if not wins[day,month+1] then
            doesWin:=true;
      if isCorrect(day,month+2) then
         if not wins[day,month+2] then
            doesWin:=true;
   end;

   procedure filltable;
   var
      day,month:integer;
   begin
      wins[31,12]:=true;
      for month:=12 downto 1 do
         for day:=dim[month] downto 1 do
            if (month<>12) or (day<>31) then
               wins[day,month]:=doesWin(day,month);
   end;

var
   day,month:integer;
begin
   filltable;
   assign(input,'dategame.in');
   reset(input);
   assign(output,'dategame.out');
   rewrite(output);
   readln(day,month);
   if wins[day,month] then
      writeln(1)
   else
      writeln(2);
end.