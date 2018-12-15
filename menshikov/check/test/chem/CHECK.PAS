{
Written by Fyodor Menshikov 03.01.2005
Difference from original checker:
non-original sides in answer is pe, not wa.
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
      halt(3);
   end;

var
   fin,fout,fchk:text;
   left,right,ua,ja:string;
   n,i:integer;
   waswa:boolean;
begin
   assign(fin,'chem.in');
   reset(fin);
   assign(fout,'chem.out');
   reset(fout);
   assign(fchk,'chem.chk');
   reset(fchk);
   readln(fin,left);
   readln(fin,n);
   waswa:=false;
   for i:=1 to n do begin
      readln(fin,right);
      readln(fout,ua);
      readln(fchk,ja);
      if(ua<>left+'=='+right)and(ua<>left+'!='+right) then
         pe;
      if ua<>ja then
         waswa:=true;
   end;
   if not eof(fout) then
      pe;
   if waswa then
      wa;
   ac;
end.