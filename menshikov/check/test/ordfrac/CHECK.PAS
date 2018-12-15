{
Written by Fyodor Menshikov 09.05.2004
Пустой файл - PE
Не набор строк "положительное/положительное" - PE
Числа больше N - PE
Числитель больше знаменателя - PE
Есть сократимые - PE
Не все - WA
Повторы - WA
Не в порядке возрастания - WA
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

   procedure pe(id:integer);
   begin
      writeln('pe',id);
      halt(2);
   end;

type
   fraction=record
      numerator,
      denominator:byte;
   end;

   function gcd(x,y:integer):integer;
   begin
      if y=0 then
         gcd:=x
      else
         gcd:=gcd(y,x mod y);
   end;

var
   n:integer;
var
   c:char;

   procedure nextchar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
   end;

   procedure number(var number:integer);
   begin
      if not (c in ['1'..'9']) then
         pe(1);
      number:=0;
      while c in ['0'..'9'] do begin
         number:=number*10+ord(c)-ord('0');
         nextchar;
         if number>n then
            pe(2);
      end;
   end;

   procedure checklinepe;
   var
      num,den:integer;
   begin
      nextchar;
      number(num);
      if c<>'/' then
         pe(3);
      nextchar;
      number(den);
      if c<>#13 then
         pe(4);
      readln;
      if not(num<den) then
         pe(5);
      if gcd(num,den)<>1 then
         pe(6);
   end;

   procedure recursewa(num_left,den_left,num_right,den_right:integer);
   var
      num_mid,den_mid,num_user,den_user:integer;
   begin
      num_mid:=num_left+num_right;
      den_mid:=den_left+den_right;

      if den_mid>n then
         exit;
      recursewa(num_left,den_left,num_mid,den_mid);

      nextchar;
      number(num_user);
      nextchar;{'/'}
      number(den_user);
      readln;
      if (num_user<>num_mid)or(den_user<>den_mid) then
         wa;

      recursewa(num_mid,den_mid,num_right,den_right);
   end;

begin
   assign(input,'ordfrac.in');
   reset(input);
   readln(n);
   assign(input,'ordfrac.out');
   reset(input);
   if eof then
      pe(7);
   while not eof do
      checklinepe;
   reset(input);
   recursewa(0,1,1,1);
   if not eof then
      wa;
   ac;
end.