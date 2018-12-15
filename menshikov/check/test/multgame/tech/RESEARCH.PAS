{
Written by Fyodor Menshikov 12.01.2004
4:27-4:52
Modified into research 19.01.2004
}
{$N+,E-}
var
   table:array[1..7000]of record
      num:comp;
      wins:boolean;
   end;
   tablen:integer;
   nn:comp;

   procedure inittable;
   begin
      tablen:=0;
   end;

   function indexOf(n:comp):integer;
   var
      l,r,mid:integer;
   begin
      l:=1;
      r:=tablen;
      while l<=r do begin
         mid:=(l+r)div 2;
         if table[mid].num<n then
            l:=mid+1
         else if table[mid].num>n then
            r:=mid-1
         else begin
            indexOf:=mid;
            exit;
         end;
      end;
      indexOf:=-1;
   end;

   function isInTable(n:comp):boolean;
   begin
      isInTable:=indexOf(n)>0;
   end;

   procedure put(n:comp);
   var
      i:integer;
   begin
      if n>=nn then
         exit;
      if isInTable(n) then
         exit;
      if tablen=high(table) then begin
         writeln('overflow');
         halt(1);
      end;
      i:=tablen;
      while (i>0)and(table[i].num>n) do begin
         table[i+1]:=table[i];
         dec(i);
      end;
      table[i+1].num:=n;
      inc(tablen);
   end;

   function wins(n:comp):boolean;
   var
      i:integer;
   begin
      wins:=table[indexOf(n)].wins;
   end;

var
   out:text;

   procedure show(nn:comp);
   var
      canwin:boolean;
      i,j:integer;
      t:comp;
   begin
      write(out,'nn: ',nn:10:0,' - ');
      write('          nn: ',nn:10:0,' - ');
      for i:=tablen downto 1 do begin
         t:=table[i].num;
         if t*9>=nn then
            table[i].wins:=true
         else begin
            canwin:=false;
            for j:=2 to 9 do
               if not wins(t*j) then begin
                  canwin:=true;
                  break;
               end;
            table[i].wins:=canwin;
         end;
      end;
      if table[1].wins then begin
         writeln(out,'Stan wins.');
         writeln('Stan wins.');
      end
      else begin
         writeln(out,'Ollie wins.');
         writeln('Ollie wins.');
      end;
   end;

var
   t:comp;
   i,j,k:integer;
begin
   assign(out,'result.txt');
   rewrite(out);
   nn:=4294967295.0;
   inittable;
   put(1);
   i:=1;
   while i<=tablen do begin
      t:=table[i].num;
      for j:=2 to 9 do
         put(t*j);
      inc(i);
   end;
   for k:=tablen downto 1 do begin
      writeln('k=',k:4);
      show(table[k].num+1);
      show(table[k].num);
      show(table[k].num-1);
      writeln(out);
   end;
   close(out);
end.