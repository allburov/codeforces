{
Written by Fyodor Menshikov (Autumn 2002)
During training
}
{$S+,R+,Q+}
var
   expr:array['A'..'Z','1'..'9']of string;
   value:array['A'..'Z','1'..'9']of longint;
   found:array['A'..'Z','1'..'9']of (no,yes,during);
var
   str:string;
   _pos:integer;
   ch:char;
const
   eol=#0;

   procedure nextchar;
   begin
      inc(_pos);
      if _pos>length(str) then
         ch:=eol
      else
         ch:=str[_pos];
   end;

   function expression:longint;forward;

   function factor:longint;
   var
      c1,c2:char;
      v:longint;
   begin
      if ch='(' then begin
         nextchar;
         v:=expression;
         if ch<>')' then
            halt(1);
         nextchar;
         factor:=v;
      end
      else if ch in ['0'..'9'] then begin
         v:=0;
         while ch in ['0'..'9'] do begin
            v:=v*10+ord(ch)-ord('0');
            nextchar;
         end;
         factor:=v;
      end
      else if ch in ['A'..'Z'] then begin
         c1:=ch;
         nextchar;
         c2:=ch;
         nextchar;
         if found[c1,c2]<>yes then
            halt(1);
         factor:=value[c1,c2];
      end
      {else if ch='-' then begin
         nextchar;
         factor:=-factor;
      end
      else if ch='+' then begin
         nextchar;
         factor:=+factor;
      end}
      else
         halt(1);
   end;

   function term:longint;
   var
      t1,t2:longint;
   begin
      t1:=factor;
      while true do begin
         if ch='*' then begin
            nextchar;
            t2:=factor;
            t1:=t1*t2;
         end
         else if ch='/' then begin
            nextchar;
            t2:=factor;
            if t2=0 then
               t1:=0
            else
               t1:=t1 div t2;
         end
         else
            break;
      end;
      term:=t1;
   end;

   function expression:longint;
   var
      t1,t2:longint;
      sign:longint;
   begin
      sign:=1;
      if ch='+' then begin
         sign:=1;
         nextchar;
      end
      else if ch='-' then begin
         sign:=-1;
         nextchar;
      end;
      t1:=term*sign;
      while true do begin
         if ch='+' then begin
            nextchar;
            t2:=term;
            t1:=t1+t2;
         end
         else if ch='-' then begin
            nextchar;
            t2:=term;
            t1:=t1-t2;
         end
         else
            break;
      end;
      expression:=t1;
   end;

   procedure compute(c1,c2:char);
   var
      i:integer;
   begin
      if found[c1,c2]=yes then
         exit
      else if found[c1,c2]=during then begin
         writeln(1000000);
         halt;
      end;
      found[c1,c2]:=during;
      for i:=1 to length(expr[c1,c2])-1 do
         if expr[c1,c2][i] in ['A'..'Z'] then
            compute(expr[c1,c2][i],expr[c1,c2][i+1]);
      str:=expr[c1,c2];
      _pos:=0;
      nextchar;
      value[c1,c2]:=expression;
      found[c1,c2]:=yes;
   end;

var
   n,i:integer;
   c1,c2,c3:char;
   s:string;
begin
   assign(input,'sprsheet.in');
   reset(input);
   for c1:='A' to 'Z' do
      for c2:='1' to '9' do begin
         expr[c1,c2]:='';
         value[c1,c2]:=0;
         found[c1,c2]:=yes;
      end;
   readln(n);
   for i:=1 to n do begin
      read(c1);
      while c1=' ' do
         read(c1);
      read(c2);
      repeat
         read(c3);
      until c3='=';
      s:='';
      while not eoln do begin
         read(c3);
         if c3=#32 then
            continue;
         if length(s)=255 then
            halt(1);
         s:=s+c3;
      end;
      readln;
      expr[c1,c2]:=s;
      found[c1,c2]:=no;
   end;
   assign(output,'sprsheet.out');
   rewrite(output);
   compute('A','1');
   writeln(value['A','1']);
end.