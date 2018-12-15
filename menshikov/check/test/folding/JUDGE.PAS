{
Written by Fyodor Menshikov 22.08.2004
19:54-20:25
}
{$M 65520,0,655360}
{$R+,Q+}
var
   info:array[1..100,1..100]of record
      isDefined:boolean;
      minLen:byte;
      isPeriodic:boolean;
      firstPartEnd:byte;
      periodLength:byte;
   end;
var
   s:string;

   function isPeriod(start,finish,len:byte):boolean;
   var
      p1,p2:byte;
   begin
      isPeriod:=false;
      if (finish-start+1)mod len<>0 then
         exit;
      p1:=start;
      p2:=start+len;
      while p2<=finish do begin
         if s[p1]<>s[p2] then
            exit;
         inc(p1);
         inc(p2);
      end;
      isPeriod:=true;
   end;

   function numLen(n:byte):byte;
   begin
      if n<10 then
         numLen:=1
      else if n<100 then
         numLen:=2
      else
         numLen:=3;
   end;

   function num2str(n:byte):string;
   var
      s:string;
   begin
      str(n,s);
      num2str:=s;
   end;

   function findLen(start,finish:integer):integer;
   var
      minLen,firstPartEnd,periodLength:byte;
   begin
      if start>finish then
         halt(1);
      if start=finish then begin
         findLen:=1;
         exit;
      end;
      if info[start,finish].isDefined then begin
         findLen:=info[start,finish].minLen;
         exit;
      end;
      minLen:=255;
      {writeln('findLen(',start,',',finish,')');}
      for firstPartEnd:=start to finish-1 do
         if findLen(start,firstPartEnd)+findLen(firstPartEnd+1,finish)<minLen then begin
            minLen:=findLen(start,firstPartEnd)+findLen(firstPartEnd+1,finish);
            info[start,finish].isPeriodic:=false;
            info[start,finish].firstPartEnd:=firstPartEnd;
            {writeln('info[',start,',',finish,'].firstPartEnd:=',firstPartEnd);}
         end;
      for periodLength:=1 to (finish-start+1)div 2 do begin
         if isPeriod(start,finish,periodLength) then
            if numLen((finish-start+1)div periodLength)+1+findLen(start,start+periodLength-1)+1<minLen then begin
               minLen:=numLen((finish-start+1)div periodLength)+1+findLen(start,start+periodLength-1)+1;
               info[start,finish].isPeriodic:=true;
               info[start,finish].periodLength:=periodLength;
            end;
      end;
      if minLen=255 then
         halt(1);
      info[start,finish].isDefined:=true;
      info[start,finish].minLen:=minLen;
      findLen:=minLen;
   end;

   function show(start,finish:integer):string;
   begin
      {writeln('show(',start,',',finish,')');}
      if start>finish then begin
         {writeln('show start>finish');}
         halt(1);
      end;
      if start=finish then begin
         show:=s[start];
         exit;
      end;
      if not info[start,finish].isDefined then
         halt(1);
      if info[start,finish].isPeriodic then begin
         {writeln('periodic');}
         show:=num2str((finish-start+1)div info[start,finish].periodLength)+
            '('+show(start,start+info[start,finish].periodLength-1)+')'
      end
      else begin
         {writeln('not periodic');}
         show:=show(start,info[start,finish].firstPartEnd)+
            show(info[start,finish].firstPartEnd+1,finish);
      end;
   end;

var
   i,j,t:integer;
begin
   assign(input,'folding.in');
   reset(input);
   assign(output,'folding.out');
   rewrite(output);
   readln(s);
   for i:=1 to 100 do
      for j:=1 to 100 do
         info[i,j].isDefined:=false;
   t:=findLen(1,length(s));
   writeln(show(1,length(s)));
end.