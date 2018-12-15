{
Written by Fyodor Menshikov 11.10.2003
3:46-4:16
}
{$R-,Q-}
type
   integer=longint;
var
   n:integer;
   price,bestplace,B:array[1..101]of integer;

   procedure count(ourplace,ourprice:integer;var curs:integer);
   var
      i:integer;
      minprice,minplace:integer;
   begin
      for i:=n downto ourplace do
         price[i+1]:=price[i];
      price[ourplace]:=ourprice;
      curs:=0;

      {->}
      minprice:=maxlongint;
      for i:=1 to n do begin
         if price[i]<=minprice then begin
            minprice:=price[i];
            minplace:=i;
         end;
         bestplace[i]:=minplace;
      end;
      for i:=1 to n do
         if bestplace[i]=ourplace then
            curs:=curs+b[i]*ourprice;
      {<-}
      minprice:=maxlongint;
      for i:=n+1 downto 2 do begin
         if price[i]<=minprice then begin
            minprice:=price[i];
            minplace:=i;
         end;
         bestplace[i]:=minplace;
      end;
      for i:=1 to n do
         if bestplace[(n+2)-i]=ourplace then
            curs:=curs+b[i]*ourprice;

      for i:=ourplace to n do
         price[i]:=price[i+1];
   end;

var
   i,j,buf:integer;
   allprices:array[1..200]of integer;
   bests,bestl,bestp:integer;
   curs,curl,curp:integer;
begin
   assign(input,'seeds.in');
   reset(input);
   assign(output,'seeds.out');
   rewrite(output);
   readln(n);
   for i:=1 to n do
      read(price[i]);
   readln;
   for i:=1 to n do
      read(b[i]);
   readln;
   for i:=1 to n do begin
      allprices[i*2-1]:=price[i];
      allprices[i*2]:=price[i]-1;
   end;
   for i:=1 to 2*n do
      for j:=1 to 2*n do
         if (i<j) and (allprices[i]>allprices[j]) then begin
            buf:=allprices[i];
            allprices[i]:=allprices[j];
            allprices[j]:=buf;
         end;
   bests:=0;
   for curl:=1 to n-1 do begin
      for curp:=1 to 2*n do begin
         count(curl+1,allprices[curp],curs);
         {writeln(curl,' ',allprices[curp],'->',curs);}
         if curs>bests then begin
            bests:=curs;
            bestl:=curl;
            bestp:=allprices[curp];
         end;
      end;
   end;
   writeln(bestl,' ',bestp);
end.