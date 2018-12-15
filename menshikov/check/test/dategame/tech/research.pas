{
Written by Fyodor Menshikov 05.01.2004
10:56-11:27
}
{$R+,Q+}
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

   procedure fill;
   var
      day,month:integer;
   begin
      wins[31,12]:=true;{who must go into 12,31 loses}
      for month:=12 downto 1 do
         for day:=dim[month] downto 1 do
            if (month<>12) or (day<>31) then
               wins[day,month]:=doesWin(day,month);
   end;

   procedure show;
   var
      day,month:integer;
   begin
      writeln('days in february: ',dim[2]);
      for month:=1 to 12 do
         for day:=1 to dim[month] do
            writeln(day div 10,day mod 10,'.',month div 10,month mod 10,' -> ',
               ord(not wins[day,month])+1);
   end;

begin
   fill;
   show;
end.