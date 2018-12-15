{
Written by Fyodor Menshikov 04.10.2003
During training
}
{$R+,Q+}
type
   integer=longint;
var
   c:char;
   value:integer;
   lex:integer;
const
   lexBEGIN=1;
   lexEND=2;
   lexLOOP=3;
   lexOP=4;
   lexN=5;
   lexNumber=6;
   lexEOF=7;

   procedure nextchar;
   begin
      if eof then
         c:=#255
      else if eoln then begin
         readln;
         c:=#32;
      end
      else
         read(c);
   end;

   procedure ident;
   var
      name:string;
   begin
      name:='';
      while c in ['A'..'Z','a'..'z','0'..'9'] do begin
         name:=name+c;
         nextchar;
      end;
      if name='BEGIN' then
         lex:=lexBEGIN
      else if name='END' then
         lex:=lexEND
      else if name='LOOP' then
         lex:=lexLOOP
      else if name='OP' then
         lex:=lexOP
      else if name='n' then
         lex:=lexN
      else begin
         writeln('ident error >',name,'<');
         halt(1);
      end;
   end;

   procedure number;
   var
      d:integer;
   begin
      value:=0;
      while c in ['0'..'9'] do begin
         d:=ord(c)-ord('0');
         if value>(maxlongint-d)div 10 then begin
            writeln('number error');
            halt(1)
         end
         else
            value:=value*10+d;
         nextchar;
      end;
      lex:=lexNumber;
   end;

   procedure nextlex;
   begin
      while c<=#32 do
         nextchar;
      case c of
      'A'..'Z','a'..'z':ident;
      '0'..'9':number;
      #255:lex:=lexEOF;
      else
         writeln('nextlex error');
         halt(1);
      end;
   end;

   procedure check(what:integer);
   begin
      if lex<>what then
         halt(1)
      else
         nextlex;
   end;

type
   tPoly=array[0..10]of integer;

   procedure showMono(coef,pow:integer);
   begin
      if pow=0 then
         write(coef)
      else begin
         if coef<>1 then
            write(coef,'*');
         write('n');
         if pow<>1 then
            write('^',pow);
      end;
   end;

   procedure show(p:tPoly);
   var
      i:integer;
   begin
      for i:=high(p) downto 0 do
         if p[i]<>0 then
            break;
      write('Runtime = ');
      showMono(p[i],i);
      for i:=i-1 downto 0 do begin
         if p[i]<0 then begin
            write('-');
            showMono(-p[i],i);
         end
         else if p[i]>0 then begin
            write('+');
            showMono(p[i],i);
         end;
      end;
      writeln;
   end;

   procedure newPolyZ(var p:tPoly);
   var
      i:integer;
   begin
      for i:=0 to high(p) do
         p[i]:=0;
   end;

   procedure newPolyC(value:integer;var p:tPoly);
   begin
      newPolyZ(p);
      p[0]:=value;
   end;

   procedure newPolyN(var p:tPoly);
   begin
      newPolyZ(p);
      p[1]:=1;
   end;

   procedure addPoly(var p1,p2:tPoly);
   var
      i:integer;
   begin
      {writeln('adding');
      show(p1);
      show(p2);}
      for i:=0 to high(p1) do
         p1[i]:=p1[i]+p2[i];
      {show(p1);}
   end;

   procedure mulPolyC(var p:tPoly;value:integer);
   var
      i:integer;
   begin
      {writeln('Multiplying');
      show(p);
      writeln(value);}
      for i:=0 to high(p) do
         p[i]:=p[i]*value;
      {show(p);}
   end;

   procedure mulPolyN(var p:tPoly);
   var
      i:integer;
   begin
      if p[high(p)]<>0 then
         halt(1);
      for i:=high(p) downto 1 do
         p[i]:=p[i-1];
      p[0]:=0;
   end;

   procedure statlist(var s:tPoly);forward;

   procedure loopStat(var p:tPoly);
   var
      v:integer;
   begin
      check(lexLOOP);
      if lex=lexNumber then
         v:=value
      else if lex=lexN then
         v:=-1
      else
         halt(1);
      {writeln('LOOP ',v);}
      nextlex;
      statlist(p);
      if v=-1 then
         mulPolyN(p)
      else
         mulPolyC(p,v);
      check(lexEND);
   end;

   procedure opStat(var p:tPoly);
   begin
      check(lexOP);
      if lex=lexNumber then begin
         newPolyC(value,p);
      end
      else if lex=lexN then begin
         newPolyN(p);
      end
      else
         halt(1);
      nextlex;
   end;

   procedure statlist(var s:tPoly);
   var
      p:tPoly;
   begin
      newPolyZ(s);
      while true do begin
         if lex=lexEND then
            break;
         if lex=lexLOOP then
            loopStat(p)
         else if lex=lexOP then
            opStat(p)
         else
            halt(1);
         addPoly(s,p);
      end;
      {writeln('statlist result:');}
      {show(s);}
   end;

   procedure parseprog;
   var
      p:tpoly;
   begin
      check(lexBEGIN);
      statlist(p);
      {write('parsing complete');}
      show(p);
      check(lexEND);
   end;

var
   progs:integer;
begin
   assign(input,'icomplex.in');
   reset(input);
   assign(output,'icomplex.out');
   rewrite(output);
   readln(progs);
   nextchar;
   nextlex;
   for progs:=1 to progs do begin
      writeln('Program #',progs);
      parseprog;
      writeln;
   end;
   {writeln('Ok');}
end.