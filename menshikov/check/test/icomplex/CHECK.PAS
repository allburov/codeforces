{
Written by Fyodor Menshikov 17.08.2004
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

   procedure pe(id:integer);
   begin
      writeln('pe'{,id});
      halt(2);
   end;

var
   c:char;

   procedure nextChar;
   begin
      if eoln then
         c:=#13
      else
         read(c);
      {write(c);}
   end;

   procedure number(var n:integer);
   var
      d:integer;
   begin
      if c in ['1'..'9'] then begin
         n:=ord(c)-ord('0');
         nextChar;
         while c in ['0'..'9'] do begin
            d:=ord(c)-ord('0');
            if n<=(maxint-d)div 10 then
               n:=n*10+d
            else
               n:=maxint;
            nextChar;
         end;
      end
      else
         pe(1);
   end;

   procedure parsePower(var maxP:integer);
   var
      p:integer;
   begin
      if c='^' then begin
         {степень 2 или более}
         nextChar;
         number(p);
         if p=1 then{степень 1 не пишется}
            pe(2);
         if p>maxP then
            pe(3);
         maxP:=p-1;
      end
      else begin
         if maxP<1 then
            pe(4);
         maxP:=0;
      end;
   end;

   procedure parseTerm(var maxP:integer);
   var
      k:integer;
   begin
      if c in ['1'..'9'] then begin
         number(k);
         if c='*' then begin
            {k - коэффициент}
            nextChar;
            if c<>'n' then
               pe(13);
            nextChar;
            parsePower(maxP);
         end
         else begin
            if maxP<0 then
               pe(5);
            maxP:=-1;
         end;
      end
      else if c='n' then begin
         {коэффициент перед степенью отсутствует}
         nextChar;
         parsePower(maxP);
      end
      else
         pe(6);
   end;

   procedure parsePoly;
   var
      maxP:integer;
   begin
      if c='0' then begin
         nextChar;
         exit;
      end;
      maxP:=10;
      parseTerm(maxP);
      while c='+' do begin
         nextChar;
         parseTerm(maxP);
      end;
   end;

var
   count:integer;

   procedure parseTest;
   var
      s,needs:string;
      i:integer;
   begin
      inc(count);
      str(count,needs);
      needs:='Program #'+needs;
      readln(s);
      if s<>needs then
         pe(7);
      s:='Runtime = ';
      nextChar;
      for i:=1 to length(s) do begin
         if c=#13 then
            pe(8);
         if c<>s[i] then
            pe(9);
         nextChar;
      end;
      parsePoly;
      if c<>#13 then
         pe(10);
      readln;
      if eof then
         exit;
      if not eoln then
         pe(12);
      readln;
   end;

var
   jf:text;
   s,js:string;
begin
   assign(input,'icomplex.out');
   reset(input);
   count:=0;
   while not eof do
      parseTest;
   reset(input);
   assign(jf,'icomplex.chk');
   reset(jf);
   while true do begin
      if eof and eof(jf) then
         ac;
      if eof(jf) then begin
         if not eoln then
            wa;
         readln;
         if not eof then
            wa;
         ac;
      end;
      if eof then
         wa;
      readln(s);
      readln(jf,js);
      if s<>js then
         wa;
   end;
end.