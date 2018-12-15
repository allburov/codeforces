{
Written by Fyodor Menshikov 20.08.2004
19:33-20:52
}
{$N+,E-}
{$R+,Q+}
type
   TState=record
   case boolean of
   true:(
      ba,ab,aa,dummy:byte;
   );
   false:(
      value:longint;
   )
   end;
   TTable=record
      k:integer;
      len:integer;
      a:array[1..1000]of record
         state:TState;
         count:comp;
      end;
   end;

   procedure initTable(var t:TTable;k:integer);
   begin
      t.k:=k;
      t.len:=0;
   end;

   procedure put(var t:TTable;aa,ab,ba,bb:integer;count:comp);
   begin
      if aa+ab+ba+bb<>t.k then begin
         writeln('put error');
         halt(1);
      end;
      inc(t.len);
      with t.a[t.len] do begin
         state.aa:=aa;
         state.ab:=ab;
         state.ba:=ba;
         state.dummy:=0;
      end;
      t.a[t.len].count:=count;
   end;

   function get(var t:TTable;aa,ab,ba,bb:integer):comp;
   var
      need:TState;
      low,high,mid,i:integer;
   begin
      if aa+ab+ba+bb<>t.k then begin
         writeln('get error');
         halt(1);
      end;
      if (aa<0)or(ab<0)or(ba<0)or(bb<0) then begin
         get:=0;
         exit;
      end;
      low:=1;
      high:=t.len;
      need.aa:=aa;
      need.ab:=ab;
      need.ba:=ba;
      need.dummy:=0;
      while true do begin
         mid:=(low+high)div 2;
         if t.a[mid].state.value=need.value then begin
            get:=t.a[mid].count;
            exit;
         end
         else if t.a[mid].state.value<need.value then
            low:=mid+1
         else
            high:=mid-1;
         if low>high then begin
            writeln('search error');
            halt(1);
         end;
      end;
   end;

var
   n,k,i:integer;
   loc1,loc2:char;
   c1,c2:char;
   count:array['A'..'B','A'..'B']of integer;
   curA,curB,prevA,prevB:TTable;
   aa,ab,ba,bb:integer;
   suma,sumb,sum:comp;
begin
   assign(input,'train-ab.in');
   reset(input);
   assign(output,'train-ab.out');
   rewrite(output);
   readln(n,k);
   readln(loc1,loc2);
   count['A','A']:=0;
   count['A','B']:=0;
   count['B','A']:=0;
   count['B','B']:=0;
   for i:=1 to n do begin
      readln(c1,c2);
      inc(count[c1,c2]);
   end;
   initTable(curA,0);
   initTable(curB,0);
   if loc2='A' then begin
      put(curA,0,0,0,0,1.0);
      put(curB,0,0,0,0,0.0);
   end
   else if loc2='B' then begin
      put(curA,0,0,0,0,0.0);
      put(curB,0,0,0,0,1.0);
   end
   else
      halt(1);
   for k:=1 to k do begin
      prevA:=curA;
      prevB:=curB;
      initTable(curA,k);
      initTable(curB,k);
      for aa:=0 to count['A','A'] do
         for ab:=0 to count['A','B'] do
            for ba:=0 to count['B','A'] do
               for bb:=0 to count['B','B'] do
                  if aa+ab+ba+bb=k then begin
                     suma:=get(prevA,aa-1,ab,ba,bb)+get(prevB,aa,ab,ba-1,bb);
                     sumb:=get(prevA,aa,ab-1,ba,bb)+get(prevB,aa,ab,ba,bb-1);
                     put(curA,aa,ab,ba,bb,suma);
                     put(curB,aa,ab,ba,bb,sumb);
                  end;
   end;
   if loc1='B' then
      curA:=curB;
   sum:=0;
   for i:=1 to curA.len do
      sum:=sum+curA.a[i].count;
   if sum=0 then
      writeln('NO')
   else begin
      writeln('YES');
      writeln(sum:0:0);
   end;
end.