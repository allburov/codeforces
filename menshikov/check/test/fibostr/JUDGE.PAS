{
Written by Fyodor Menshikov 22.05.2002
10:28-11:05
I/O filename changed 03.04.2004
Output to screen removed 03.01.2005
I/O filename changed 12.01.2005
}
const
   maxn=45;

   procedure out(q:longint);
   begin
      assign(output,'fibostr.out');
      rewrite(output);
      writeln(q);
      halt;
   end;

   function entries(main,sub:string):integer;
   label
      01;
   var
      start,offset,count:integer;
   begin
      count:=0;
      for start:=1 to length(main)-length(sub)+1 do begin
         for offset:=1 to length(sub) do begin
            if main[start+offset-1]<>sub[offset] then
               goto 01;
         end;
         inc(count);
      01:
      end;
      entries:=count;
   end;

var
   F:array[1..12]of string;
   Fstart:array[11..maxn]of string;
   Fend:array[11..maxn]of string;
   Fcount:array[11..maxn]of longint;
var
   n,k:integer;
   s:string;
   slen:integer;
begin
   F[1]:='A';
   F[2]:='B';
   for n:=3 to 12 do
      F[n]:=F[n-1]+F[n-2];
   assign(input,'fibostr.in');
   reset(input);
   readln(n);
   readln(s);
   if n<=12 then
      out(entries(F[n],s));
   slen:=length(s);

   Fstart[11]:=copy(F[11],1,slen-1);
   Fend[11]:=copy(F[11],length(F[11])-slen+2,slen-1);
   Fcount[11]:=entries(F[11],s);

   Fstart[12]:=copy(F[12],1,slen-1);
   Fend[12]:=copy(F[12],length(F[12])-slen+2,slen-1);
   Fcount[12]:=entries(F[12],s);

   for k:=13 to n do begin
      Fstart[k]:=Fstart[k-1];
      Fend[k]:=Fend[k-2];
      Fcount[k]:=Fcount[k-1]+Fcount[k-2]+entries(Fend[k-1]+Fstart[k-2],s);
   end;
   out(Fcount[n]);
end.