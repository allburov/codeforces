{
Written by Fyodor Menshikov 11.11.2004
Difference from original checker:
non-original order is pe, not wa.
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
      writeln('pe');
      halt(2);
   end;

var
   fchk:text;
   j,i,n,jl,ul,prev,cur:longint;
   s,js:string;
   name:array[1..1000]of string[12];
   found:boolean;
begin
   assign(input,'dialogue.in');
   reset(input);
   readln(n);
   for i:=1 to n do
      readln(name[i]);
   assign(input,'dialogue.out');
   reset(input);
   if eoln then
      pe(1);
   {$I-}
   read(ul);
   {$I+}
   if ioresult<>0 then
      pe(2);
   if not eoln then
      pe(8);
   readln;
   if (ul<0)or(ul>n) then
      pe(3);
   {checking that names are original}
   for i:=1 to ul do begin
      if eof then
         pe(4);
      readln(s);
      found:=false;
      for j:=1 to n do
         if s=name[j] then
            found:=true;
      if not found then begin
         pe(5);
      end;
   end;
   if not eof then
      pe(6);
   {checking that sequence is original}
   reset(input);
   readln;
   prev:=-1;
   for i:=1 to ul do begin
      readln(s);
      cur:=-2;
      for j:=1 to n do
         if s=name[j] then
            cur:=j;
      if cur<=prev then
         pe(7);
      prev:=cur;
   end;
   {checking that answer is like judge one}
   reset(input);
   readln;
   assign(fchk,'dialogue.chk');
   reset(fchk);
   readln(fchk,jl);
   if ul<>jl then
      wa;
   for i:=1 to ul do begin
      read(s);
      read(fchk,js);
      if s<>js then
         wa;
   end;
   ac;
end.