{
Written by Fyodor Menshikov 20.08.2004
18:38-19:15 + 19:24-19:30
}
{$N+,E-}
{$R+,Q+}
   function min(x,y:integer):integer;
   begin
      if x<y then
         min:=x
      else
         min:=y;
   end;
   
var
   C:array[0..80,0..40]of extended;

   procedure initC;
   var
      n,k:integer;
   begin
      for n:=0 to 80 do
         for k:=0 to min(n,40) do
            if k=0 then
               C[n,k]:=1
            else if k=n then
               C[n,k]:=1
            else
               C[n,k]:=C[n-1,k-1]+C[n-1,k];
   end;

var
   n,k,i:integer;
   loc1,loc2,c1,c2:char;
   id:string;
   count:array ['A'..'B','A'..'B'] of integer;
   countABBA,countBAAB,countAB,countBA,countAA,countBB,placesAA,placesBB:integer;
   sum,mulAA,mulBB:extended;
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
   initC;
   sum:=0;
   if (loc1='A')and(loc2='A') then begin
      for countABBA:=0 to min(count['A','B'],count['B','A']) do begin
         for countAA:=0 to count['A','A'] do
            for countBB:=0 to count['B','B'] do
               if countABBA*2+countAA+countBB=k then begin
                  placesAA:=countABBA+1;
                  placesBB:=countABBA;
                  mulAA:=C[countAA+placesAA-1,countAA];
                  if placesBB=0 then
                     mulBB:=1
                  else
                     mulBB:=C[countBB+placesBB-1,countBB];
                  sum:=sum+mulAA*mulBB;
               end;
      end;
   end
   else if (loc1='B')and(loc2='B') then begin
      for countBAAB:=0 to min(count['A','B'],count['B','A']) do begin
         for countAA:=0 to count['A','A'] do
            for countBB:=0 to count['B','B'] do
               if countBAAB*2+countAA+countBB=k then begin
                  placesAA:=countBAAB;
                  placesBB:=countBAAB+1;
                  if placesAA=0 then
                     mulAA:=1
                  else
                     mulAA:=C[countAA+placesAA-1,countAA];
                  mulBB:=C[countBB+placesBB-1,countBB];
                  sum:=sum+mulAA*mulBB;
               end;
      end;
   end
   else if (loc1='A')and(loc2='B') then begin
      for countBA:=1 to min(count['B','A'],count['A','B']+1) do begin
         for countAA:=0 to count['A','A'] do
            for countBB:=0 to count['B','B'] do
               if countBA*2-1+countAA+countBB=k then begin
                  placesAA:=countBA;
                  placesBB:=countBA;
                  mulAA:=C[countAA+placesAA-1,countAA];
                  mulBB:=C[countBB+placesBB-1,countBB];
                  sum:=sum+mulAA*mulBB;
               end;
      end;
   end
   else if (loc1='B')and(loc2='A') then begin
      for countAB:=1 to min(count['A','B'],count['B','A']+1) do begin
         for countAA:=0 to count['A','A'] do
            for countBB:=0 to count['B','B'] do
               if countAB*2-1+countAA+countBB=k then begin
                  placesAA:=countAB;
                  placesBB:=countAB;
                  mulAA:=C[countAA+placesAA-1,countAA];
                  mulBB:=C[countBB+placesBB-1,countBB];
                  sum:=sum+mulAA*mulBB;
               end;
      end;
   end
   else
      halt(1);
   if sum=0 then
      writeln('NO')
   else begin
      writeln('YES');
      writeln(sum:0:0);
   end;
end.