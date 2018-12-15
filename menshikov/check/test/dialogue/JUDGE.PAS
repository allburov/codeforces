{
Written by Fyodor Menshikov 06.10.2001
during training
}
var
   inp,out:text;
   n,m:longint;
   i:longint;
   a,b:array [0..1000]of record
      name:string[8];
      ext:string[3];
      full:string[12];
      no:integer;
   end;
   c:char;
   waspt:boolean;

   procedure sortext(l,r:integer);
   var
      key:string;
      i,j:integer;
   begin
      key:=a[(l+r)div 2].ext;
      i:=l;
      j:=r;
      repeat
         while a[i].ext<key do
            inc(i);
         while a[j].ext>key do
            dec(j);
         if i<=j then begin
            a[0]:=a[i];
            a[i]:=a[j];
            a[j]:=a[0];
            inc(i);
            dec(j);
         end;
      until i>j;
      if l<j then
         sortext(l,j);
      if i<r then
         sortext(i,r);
   end;

   procedure sortname(l,r:integer);
   var
      key:string;
      i,j:integer;
   begin
      key:=a[(l+r)div 2].name;
      i:=l;
      j:=r;
      repeat
         while a[i].name<key do
            inc(i);
         while a[j].name>key do
            dec(j);
         if i<=j then begin
            a[0]:=a[i];
            a[i]:=a[j];
            a[j]:=a[0];
            inc(i);
            dec(j);
         end;
      until i>j;
      if l<j then
         sortname(l,j);
      if i<r then
         sortname(i,r);
   end;

   procedure sortno(l,r:integer);
   var
      key:integer;
      i,j:integer;
   begin
      key:=a[(l+r)div 2].no;
      i:=l;
      j:=r;
      repeat
         while a[i].no<key do
            inc(i);
         while a[j].no>key do
            dec(j);
         if i<=j then begin
            a[0]:=a[i];
            a[i]:=a[j];
            a[j]:=a[0];
            inc(i);
            dec(j);
         end;
      until i>j;
      if l<j then
         sortno(l,j);
      if i<r then
         sortno(i,r);
   end;

   procedure kill1ext;
   var
      old:string;
      count:integer;
      bp:integer;
   begin
      old:='/';
      count:=1;
      bp:=0;
      a[0].ext:='\';
      for i:=n downto 0 do begin
         if a[i].ext<>old then begin
            if count<>1 then begin
               while count>0 do begin
                  inc(bp);
                  b[bp]:=a[i+count];
                  dec(count);
               end;
            end;
            old:=a[i].ext;
            count:=1;
         end
         else begin
            inc(count);
         end;
      end;
      a:=b;
      n:=bp;
   end;

   procedure kill1name;
   var
      old:string;
      count:integer;
      bp:integer;
   begin
      old:='/';
      count:=1;
      bp:=0;
      a[0].name:='\';
      for i:=n downto 0 do begin
         if a[i].name<>old then begin
            if count<>1 then begin
               while count>0 do begin
                  inc(bp);
                  b[bp]:=a[i+count];
                  dec(count);
               end;
            end;
            old:=a[i].name;
            count:=1;
         end
         else begin
            inc(count);
         end;
      end;
      a:=b;
      n:=bp;
   end;

begin
   assign(inp,'dialogue.in');
   reset(inp);
   assign(out,'dialogue.out');
   rewrite(out);
   readln(inp,n,m);
   for i:=1 to n do begin
      with a[i] do begin
         name:='';
         ext:='';
         full:='';
         no:=i;
         waspt:=false;
         while not eoln(inp)do begin
            read(inp,c);
            full:=full+c;
            if c='.' then
               waspt:=true
            else if waspt then
               ext:=ext+c
            else
               name:=name+c;
         end;
         readln(inp);
      end;
   end;
   while true do begin
      if m=0 then
         break;
      sortext(1,n);
      kill1ext;
      dec(m);
      if m=0 then
         break;
      sortname(1,n);
      kill1name;
      dec(m);
   end;
   sortno(1,n);
   writeln(out,n);
   for i:=1 to n do
      writeln(out,a[i].full);
   close(inp);
   close(out);
end.
