{
Written by Fyodor Menshikov 15.04.2004
10:23-11:33 linear search 8s on max test
by 12:03 tree added, debugged by 12:28 - 2.25s on max test
22.04.2004 bug fixed: player wins not when <=2*k cells, but when <=3*k-2
}
type
   situation=record
      amount:byte;
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
            writeln('in input neither O nor X');
            halt(1);
         end;
      end;
      if not eoln then begin
         writeln('extra characters in input');
         halt(1);
      end;
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
         if not (a[i] in ['O','X']) then begin
            writeln('in input neither O nor X');
            halt(1);
         end;
      end;
      if not eoln then begin
         writeln('extra characters in input');
         halt(1);
      end;
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

type
   tptr=^titem;
   titem=record
      key:situation;
      wins:integer;{0 - unknown, 1 - wins, -1 - loses}
      next:tptr;
      left,right:tptr;
   end;
const
   tree:tptr=nil;
   lastAdded:tptr=nil;
   currentNode:tptr=nil;

   function cmp(var s1,s2:situation):integer;
   var
      i:integer;
   begin
      if s1.amount<s2.amount then begin
         cmp:=-1;
         exit;
      end
      else if s1.amount>s2.amount then begin
         cmp:=1;
         exit;
      end;
      for i:=1 to s1.amount do begin
         if s1.len[i]<s2.len[i] then begin
            cmp:=-1;
            exit;
         end
         else if s1.len[i]>s2.len[i] then begin
            cmp:=1;
            exit;
         end;
      end;
      cmp:=0;
   end;

   function findTree(t:tptr;var s:situation):tptr;
   begin
      if t=nil then
         findTree:=nil
      else begin
         case cmp(s,t^.key) of
         0:findTree:=t;
         -1:findTree:=findTree(t^.left,s);
         1:findTree:=findTree(t^.right,s);
         else
            writeln('cmp result out of {-1,0,1}');
            halt(1);
         end;
      end;
   end;

   procedure addTree(var t:tptr;leaf:tptr);
   begin
      if t=nil then begin
         t:=leaf;
      end
      else begin
         case cmp(leaf^.key,t^.key) of
         0:begin
            writeln('addTree, key exists');
            halt(1);
         end;
         -1:addTree(t^.left,leaf);
         1:addTree(t^.right,leaf);
         else 
            writeln('cmp result out of {-1,0,1}');
            halt(1);
         end;
      end;
   end;

   procedure showSituation(s:situation);
   var
      i:integer;
   begin
      for i:=1 to s.amount-1 do
         write(s.len[i],' ');
      writeln(s.len[s.amount]);
   end;

   procedure showTree(p:tptr);
   begin
      if p<>nil then begin
         showTree(p^.left);
         showSituation(p^.key);
         showTree(p^.right);
      end;
   end;

   procedure addTable(s:situation);
   var
      i:integer;
      leaf:tptr;
   begin
      norm(s);
      if s.amount=0 then
         exit;
      {writeln('trying to add');
      showSituation(s);}
      if findTree(tree,s)<>nil then begin
         {writeln('already present');}
         exit;
      end;
      new(leaf);
      leaf^.key:=s;
      leaf^.wins:=0;
      leaf^.next:=nil;
      leaf^.left:=nil;
      leaf^.right:=nil;
      if lastAdded=nil then begin
         lastAdded:=leaf;
         currentNode:=leaf;
      end
      else begin
         lastAdded^.next:=leaf;
         lastAdded:=leaf;
      end;
      addTree(tree,leaf);
      {writeln('node added');
      showTree(tree);}
   end;

   function completeTable:boolean;
   begin
      {writeln('currentNode=nil:',currentNode=nil);}
      completeTable:=currentNode=nil;
   end;

   procedure getTable(var s:situation);
   begin
      s:=currentNode^.key;
      {writeln('getting');
      showSituation(s);}
   end;

   procedure nextCurrent;
   begin
      currentNode:=currentNode^.next;
   end;

   function findTable(s:situation):tptr;
   var
      p:tptr;
   begin
      norm(s);
      p:=findTree(tree,s);
      if p=nil then begin
         write('key not found ');
         showSituation(s);
         halt(1);
      end;
      findTable:=p;
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

   function canWin(p:tptr):boolean;
   var
      s,s2:situation;
      i,j:integer;
   begin
      if p^.wins<>0 then begin
         canWin:=p^.wins=1;
         exit;
      end;
      s:=p^.key;
      {write('working with ');
      showSituation(s);
      writeln('s.amount=',s.amount,' s.len[1]=',s.len[1],' 3*k-2=',3*k-2);}
      if (s.amount=1)and(s.len[1]<=3*k-2) then begin
         p^.wins:=1;
         canWin:=true;
         {write('return from ');
         showSituation(s);}
         exit;
      end;
      for i:=1 to s.amount do begin
         {write('for situation ');
         showSituation(s);}
         if s.len[i]=k then begin
            s2:=s;
            s2.len[i]:=0;
            if not canWin(findTable(s2)) then begin
               p^.wins:=1;
               canWin:=true;
               {write('return from ');
               showSituation(s);}
               exit;
            end;
         end
         else begin
            s2:=s;
            s2.len[i]:=s2.len[i]-k;
            if not canWin(findTable(s2)) then begin
               p^.wins:=1;
               canWin:=true;
               {write('return from ');
               showSituation(s);}
               exit;
            end;
            for j:=1 to (s.len[i]-k)div 2 do begin
               s2:=s;
               s2.len[i]:=j;
               inc(s2.amount);
               s2.len[s2.amount]:=s.len[i]-k-j;
               if not canWin(findTable(s2)) then begin
                  p^.wins:=1;
                  canWin:=true;
                  {write('return from ');
                  showSituation(s);}
                  exit;
               end;
            end;
         end;
      end;
      p^.wins:=-1;
      canWin:=false;
      {write('return from ');
      showSituation(s);}
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
   addTable(s);
   while not completeTable do begin
      getTable(s);
      createVariants(s);
      nextCurrent;
   end;
   {writeln('table complete');
   ShowTree(tree);}
   if canwin(tree) then
      writeln(1)
   else
      writeln(2);
end.