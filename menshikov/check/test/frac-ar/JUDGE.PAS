{
Written by Fyodor Menshikov 22.11.2003
10:30-10:58
}
{$N+,E-}
type
   fraction=record
      num,denom:comp;
   end;

   procedure ie(code:integer);
   begin
      writeln('IE',code);
      halt(1);
   end;

   procedure load(var f:fraction);
   var
      s,s1:string;
      sign,int:integer;
      e:integer;
   begin
      readln(s);
      sign:=1;
      if s[1]='-' then begin
         sign:=-1;
         delete(s,1,1);
      end;
      if pos(' ',s)=0 then begin
         if pos('/',s)=0 then begin
            val(s,f.num,e);
            if e<>0 then
               ie(1);
            f.denom:=1;
         end
         else begin
            s1:=copy(s,1,pos('/',s)-1);
            delete(s,1,pos('/',s));
            val(s1,f.num,e);
            if e<>0 then
               ie(1);
            val(s,f.denom,e);
            if e<>0 then
               ie(1);
         end;
      end
      else begin
         s1:=copy(s,1,pos(' ',s)-1);
         val(s1,int,e);
         if e<>0 then
            ie(1);
         delete(s,1,pos(' ',s));
         s1:=copy(s,1,pos('/',s)-1);
         val(s1,f.num,e);
         if e<>0 then
            ie(1);
         delete(s,1,pos('/',s));
         val(s,f.denom,e);
         if e<>0 then
            ie(1);
         f.num:=f.num+f.denom*int;
      end;
      f.num:=f.num*sign;
   end;

   function _mod(x,y:comp):comp;
   begin
      _mod:=x-int(x/y)*y;
   end;

   function gcd(a,b:comp):comp;
   begin
      if a=0 then
         gcd:=b
      else
         gcd:=gcd(_mod(b,a),a);
   end;

   procedure sokr(var f:fraction);
   var
      sign:integer;
      g:comp;
   begin
      sign:=1;
      if f.num<0 then begin
         f.num:=-f.num;
         sign:=-sign;
      end;
      if f.denom<0 then begin
         f.denom:=-f.denom;
         sign:=-sign;
      end;
      g:=gcd(f.num,f.denom);
      f.num:=f.num/g;
      f.denom:=f.denom/g;
      f.num:=f.num*sign;
   end;

   procedure show(f:fraction);
   var
      s:integer;
      a,b,c:integer;
   begin
      if f.num=0 then begin
         writeln('0');
         halt;
      end;
      if f.num<0 then begin
         write('-');
         f.num:=-f.num;
      end;
      a:=round(int(f.num/f.denom));
      b:=round(_mod(f.num,f.denom));
      c:=round(f.denom);
      if (a<>0) and (b=0) then begin
         writeln(a);
         halt;
      end;
      if (a=0) and (b<>0) then begin
         writeln(b,'/',c);
         halt;
      end;
      writeln(a,' ',b,'/',c);
      halt;
   end;

var
   n1,n2,res:fraction;
   sign:char;
begin
   assign(input,'frac-ar.in');
   reset(input);
   assign(output,'frac-ar.out');
   rewrite(output);
   load(n1);
   readln(sign);
   load(n2);
   case sign of
   '+':begin
      res.num:=n1.num*n2.denom+n2.num*n1.denom;
      res.denom:=n1.denom*n2.denom;
   end;
   '-':begin
      res.num:=n1.num*n2.denom-n2.num*n1.denom;
      res.denom:=n1.denom*n2.denom;
   end;
   '*':begin
      res.num:=n1.num*n2.num;
      res.denom:=n1.denom*n2.denom;
   end;
   '/':begin
      res.num:=n1.num*n2.denom;
      res.denom:=n1.denom*n2.num;
   end
   else
      ie(1);
   end;
   sokr(res);
   show(res);
end.