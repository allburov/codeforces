{
Written by Fyodor Menshikov 15.04.2004
10:23-11:33 linear search 8s on max test
22.04.2004 bug fixed: player wins not when <=2*k cells, but when <=3*k-2
}
{-$R+,Q+}
type
   situation=record
      amount:integer;
      len:array[1..13]of byte;
   end;
var
   n,k:integer;

   procedure k1game;
   var{game for k=1}
      c:char;
      i:integer;
      Ocount:integer;
   begin
      Ocount:=0;
      for i:=1 to n do begin
         read(c);
         case c of
         'O':inc(Ocount);
         'X':{nothing};
         else
            halt(1);
         end;
      end;
      if not eoln then
         halt(1);
      if Ocount=0 then
         writeln(0)
      else if odd(Ocount) then
         writeln(1)
      else
         writeln(2);
      halt;
   end;

   procedure norm1(var s:situation);
   var{sorts len by non-increase}
      i,j:integer;
      t:byte;
   begin
      for i:=1 to s.amount do
         for j:=1 to s.amount do
            if (i<j)and(s.len[i]<s.len[j]) then begin
               t:=s.len[i];
               s.len[i]:=s.len[j];
               s.len[j]:=t;
            end;
   end;

   procedure norm2(var s:situation);
   begin{kills all zeros. len must be sorted}
      while (s.amount>0)and(s.len[s.amount]=0) do
         dec(s.amount);
   end;

   procedure norm(var s:situation);
   var{len<k => 0, k<len<2k => k}
      i:integer;
   begin
      norm1(s);
      for i:=1 to s.amount do
         if s.len[i]<k then
            s.len[i]:=0
         else if s.len[i]<2*k then
            s.len[i]:=k;
      norm2(s);
   end;

   procedure loadStart(var s:situation);
   var
      a:array[1..41]of char;
      i:integer;
      len:integer;
   begin
      for i:=1 to n do begin
         read(a[i]);
         if not (a[i] in ['O','X']) then
            halt(1);
      end;
      if not eoln then
         halt(1);
      a[n+1]:='X';
      len:=0;
      s.amount:=0;
      for i:=1 to n+1 do
         if a[i]='O' then
            inc(len)
         else {a[i]='X'} if len>0 then begin
            inc(s.amount);
            s.len[s.amount]:=len;
            len:=0;
         end;
      norm(s);
   end;

   function equal(var s1,s2:situation):boolean;
   var
      i:integer;
   begin
      equal:=false;
      if s1.amount<>s2.amount then
         exit;
      for i:=1 to s1.amount do
         if s1.len[i]<>s2.len[i] then
            exit;
      equal:=true;
   end;

var
   table:array[1..3500]of situation;
   tabptr,tablen:integer;
   wins:array[1..3500]of integer;{0 - unknown, 1 - wins, -1 - loses}

   procedure initTable;
   begin
      tabptr:=1;
      tablen:=0;
   end;

   procedure addTable(s:situation);
   var
      i:integer;
   begin
      norm(s);
      if s.amount=0 then
         exit;
      for i:=tablen downto 1 do
         if equal(s,table[i]) then
            exit;
      inc(tablen);
      if tablen>high(table) then begin
         writeln('tablen>high(table)');
         halt(1);
      end;
      table[tablen]:=s;
   end;

   function completeTable:boolean;
   begin
      completeTable:=tabptr>tablen;
   end;

   procedure getTable(var s:situation);
   begin
      s:=table[tabptr];
      inc(tabptr);
   end;

   procedure createVariants(s:situation);
   var
      s2:situation;
      i,j:integer;
   begin
      for i:=1 to s.amount do begin
         if s.len[i]=k then begin
            s2:=s;
            s2.len[i]:=0;
            addTable(s2);
         end
         else begin
            s2:=s;
            s2.len[i]:=s2.len[i]-k;
            addTable(s2);
            for j:=1 to (s.len[i]-k)div 2 do begin
               s2:=s;
               s2.len[i]:=j;
               inc(s2.amount);
               s2.len[s2.amount]:=s.len[i]-k-j;
               addTable(s2);
            end;
         end;
      end;
   end;

   function find(s:situation):integer;
   var
      i:integer;
   begin
      norm(s);
      for i:=tablen downto 1 do
         if equal(table[i],s) then begin
            find:=i;
            exit;
         end;
      halt(1);
   end;

   procedure initWins;
   var
      i:integer;
   begin
      for i:=tablen downto 1 do
         wins[i]:=0;
   end;

   function canWin(index:integer):boolean;
   var
      s,s2:situation;
      i,j:integer;
   begin
      if wins[index]<>0 then begin
         canWin:=wins[index]=1;
         exit;
      end;
      s:=table[index];
      if (s.amount=1)and(s.len[1]<=3*k-2) then begin
         wins[index]:=1;
         canWin:=true;
         exit;
      end;
      for i:=1 to s.amount do begin
         if s.len[i]=k then begin
            s2:=s;
            s2.len[i]:=0;
            if not canWin(find(s2)) then begin
               wins[index]:=1;
               canWin:=true;
               exit;
            end;
         end
         else begin
            s2:=s;
            s2.len[i]:=s2.len[i]-k;
            if not canWin(find(s2)) then begin
               wins[index]:=1;
               canWin:=true;
               exit;
            end;
            for j:=1 to (s.len[i]-k)div 2 do begin
               s2:=s;
               s2.len[i]:=j;
               inc(s2.amount);
               s2.len[s2.amount]:=s.len[i]-k-j;
               if not canWin(find(s2)) then begin
                  wins[index]:=1;
                  canWin:=true;
                  exit;
               end;
            end;
         end;
      end;
      wins[index]:=-1;
      canWin:=false;
   end;

var
   s:situation;
begin
   assign(input,'crossgam.in');
   reset(input);
   assign(output,'crossgam.out');
   rewrite(output);
   readln(n,k);
   if k=1 then
      k1game;
   loadStart(s);
   if s.amount=0 then begin{no valid move}
      writeln(0);
      halt;
   end;
   initTable;
   addTable(s);
   while not completeTable do begin
      getTable(s);
      createVariants(s);
   end;
   {writeln('tablen=',tablen);}
   initWins;
   if canwin(1) then
      writeln(1)
   else
      writeln(2);
end.