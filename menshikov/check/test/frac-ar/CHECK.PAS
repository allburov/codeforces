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

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

var
   ch:char;

   procedure nextChar;
   begin
      if eoln then
         ch:=#13
      else
         read(ch);
   end;

   procedure number(var n:integer);
   begin
      if ch='0' then begin
         nextChar;
         n:=0;
      end
      else if ch in ['1'..'9'] then begin
         n:=ord(ch)-ord('0');
         nextChar;
         while ch in ['0'..'9'] do begin
            if (n>3000)or(n=3000)and(ch<>'0') then
               pe;
            n:=n*10+ord(ch)-ord('0');
            nextChar;
         end;
      end
      else
         pe;
   end;

   function gcd(x,y:integer):integer;
   begin
      if y=0 then
         gcd:=x
      else
         gcd:=gcd(y,x mod y);
   end;

var
   t,num,den:integer;
   wasMinus:boolean;
   userAns,judgeAns:string;
begin
   assign(input,'frac-ar.out');
   reset(input);
   nextChar;

   if ch='-' then begin
      nextChar;
      wasMinus:=true;
   end
   else
      wasMinus:=false;

   number(t);
   if ch=#13 then begin
      if wasMinus and (t=0) then
         pe;
   end
   else if ch='/' then begin
      if t=0 then
         pe;
      num:=t;
      nextChar;
      number(t);
      if t=0 then
         pe;
      den:=t;
      if gcd(num,den)<>1 then
         pe;
      if ch<>#13 then
         pe;
   end
   else if ch=' ' then begin
      if t=0 then
         pe;
      nextChar;
      number(t);
      if t=0 then
         pe;
      num:=t;
      if ch<>'/' then
         pe;
      nextChar;
      number(t);
      if t=0 then
         pe;
      den:=t;
      if gcd(num,den)<>1 then
         pe;
      if ch<>#13 then
         pe;
   end
   else
      pe;
   reset(input);
   readln(userAns);
   assign(input,'frac-ar.chk');
   reset(input);
   readln(judgeAns);
   if userAns<>judgeAns then
      wa
   else
      ac;
end.