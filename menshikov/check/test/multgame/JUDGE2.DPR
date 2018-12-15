{
Written by Fyodor Menshikov 08.09.2002
18:32-19:05
Delphi!
}
{$N+,E-}
const
   max2=31;{31;/25;}
   max3=20;{20;/15;}
   max5=13;{13;/10;}
   max7=11;{11;/8;}
type
   tenum=(free,loses,wins);
var
   a:array[0..max2,0..max3,0..max5,0..max7]of tenum;

   function get(i2,i3,i5,i7:integer):tenum;
   begin
      if (i2>max2)or(i3>max3)or(i5>max5)or(i7>max7) then
         get:=loses
      else
         get:=a[i2,i3,i5,i7];
   end;

var
   n:comp;
   t:extended;
   c2,c3,c5,c7,i:integer;
begin
   assign(input,'input.txt');
   reset(input);
   assign(output,'output.txt');
   rewrite(output);
   while not eof do begin
      readln(n);
      for c2:=0 to max2 do
         for c3:=0 to max3 do
            for c5:=0 to max5 do
               for c7:=0 to max7 do
                  a[c2,c3,c5,c7]:=free;
      for c2:=0 to max2 do
         for c3:=0 to max3 do
            for c5:=0 to max5 do
               for c7:=0 to max7 do begin
                  t:=1;
                  for i:=1 to c2 do
                     t:=t*2;
                  for i:=1 to c3 do
                     t:=t*3;
                  for i:=1 to c5 do
                     t:=t*5;
                  for i:=1 to c7 do
                     t:=t*7;
                  if t>=n then
                     a[c2,c3,c5,c7]:=loses;
               end;
      while a[0,0,0,0]=free do begin
         for c2:=max2 downto 0 do
            for c3:=max3 downto 0 do
               for c5:=max5 downto 0 do
                  for c7:=max7 downto 0 do
                     if a[c2,c3,c5,c7]=free then begin
                        if (get(c2+1,c3,c5,c7)<>free){*2}and
                           (get(c2,c3+1,c5,c7)<>free){*3}and
                           (get(c2+2,c3,c5,c7)<>free){*4}and
                           (get(c2,c3,c5+1,c7)<>free){*5}and
                           (get(c2+1,c3+1,c5,c7)<>free){*6}and
                           (get(c2,c3,c5,c7+1)<>free){*7}and
                           (get(c2+3,c3,c5,c7)<>free){*8}and
                           (get(c2,c3+2,c5,c7)<>free){*9}
                        then begin
                           if (get(c2+1,c3,c5,c7)=wins){*2}and
                              (get(c2,c3+1,c5,c7)=wins){*3}and
                              (get(c2+2,c3,c5,c7)=wins){*4}and
                              (get(c2,c3,c5+1,c7)=wins){*5}and
                              (get(c2+1,c3+1,c5,c7)=wins){*6}and
                              (get(c2,c3,c5,c7+1)=wins){*7}and
                              (get(c2+3,c3,c5,c7)=wins){*8}and
                              (get(c2,c3+2,c5,c7)=wins){*9}
                           then
                              a[c2,c3,c5,c7]:=loses
                           else
                              a[c2,c3,c5,c7]:=wins;
                        end;
                     end;
      end;
      if a[0,0,0,0]=wins then
         writeln('Stan wins.')
      else
         writeln('Ollie wins.');
   end;
end.