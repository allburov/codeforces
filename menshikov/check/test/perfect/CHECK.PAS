{
Written by Fyodor Menshikov 22.12.2003
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

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

const
   perfect:array[1..5]of longint=(6,28,496,8128,33550336);
var
   m,n,a,prev:longint;
   s:string;
   i,e:integer;
   found:boolean;
begin
   assign(input,'perfect.in');
   reset(input);
   readln(m,n);
   assign(input,'perfect.out');
   reset(input);
   readln(s);
   if s='Absent' then begin
      if not eof then
         pe;
      for i:=1 to 5 do
         if (m<=perfect[i])and(perfect[i]<=n) then
            wa;
      ac;
   end
   else begin
      reset(input);
      prev:=0;
      while not eof do begin
         readln(s);
         if (s[1]=' ')or(s[length(s)]=' ') then
            pe;
         val(s,a,e);
         if e<>0 then
            pe;
         if (a<m)or(n<a) then
            pe;
         if a<=prev then
            pe;
         prev:=a;
      end;
      reset(input);
      for i:=1 to 5 do
         if (m<=perfect[i])and(perfect[i]<=n) then begin
            if eof then
               wa;
            readln(a);
            if a<>perfect[i] then
               wa;
         end;
      if not eof then
         wa;
      ac;
   end;
end.