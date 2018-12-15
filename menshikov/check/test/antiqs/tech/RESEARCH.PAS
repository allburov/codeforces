{
Written by Fyodor Menshikov 04.04.2004
11:41-11:59
}
const
   maxn=6;
var
   a1,a2:array[1..maxn]of integer;
   len:integer;
   max,sum:integer;

   procedure swap(i1,i2:integer);
   var
      t:integer;
   begin
      t:=a1[i1];
      a1[i1]:=a1[i2];
      a1[i2]:=t;
   end;

   procedure qsort(l,r:integer);
   var
      i,j,k,buf:integer;
   begin
      k:=a2[(l+r)div 2];
      i:=l;
      j:=r;
      repeat
         inc(sum,2);
         while a2[i]<k do begin
            inc(i);
            inc(sum);
         end;
         while k<a2[j] do begin
            dec(j);
            inc(sum);
         end;
         if i<=j then begin
            buf:=a2[i];
            a2[i]:=a2[j];
            a2[j]:=buf;
            inc(i);
            dec(j);
         end;
      until i>j;
      if l<j then
         qsort(l,j);
      if i<r then
         qsort(i,r);
   end;

   procedure perebor1(place:integer);
   var
      i:integer;
   begin
      if place=len then begin
         a2:=a1;
         sum:=0;
         qsort(1,len);
         if sum>max then
            max:=sum;
         exit;
      end;
      for i:=place to len do begin
         swap(place,i);
         perebor1(place+1);
         swap(place,i);
      end;
   end;

   procedure perebor2(place:integer);
   var
      i:integer;
   begin
      if place=len then begin
         a2:=a1;
         sum:=0;
         qsort(1,len);
         if sum=max then begin
            for i:=1 to len do
               write(a1[i],' ');
            writeln;
         end;
         exit;
      end;
      for i:=place to len do begin
         swap(place,i);
         perebor2(place+1);
         swap(place,i);
      end;
   end;

var
   i:integer;
begin
   for i:=1 to maxn do
      a1[i]:=i;
   for len:=1 to maxn do begin
      writeln('len=',len);
      max:=0;
      perebor1(1);{updates max}
      writeln('max=',max);
      perebor2(1);{shows max}
   end;
end.