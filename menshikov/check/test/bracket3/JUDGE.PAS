{
Written by Fyodor Menshikov 17.04.2002
21:27-22:02
}
{$M 65520,0,655360}
var
   n:integer;
   br:array[1..100]of char;
   minlen:array[1..100,1..100]of integer;

   procedure load;
   begin
      assign(input,'bracket3.in');
      reset(input);
      n:=0;
      while not eoln do begin
         inc(n);
         read(br[n]);
      end;
      close(input);
   end;

   function len(_from,_to:integer):integer;
   var
      min,i:integer;
   begin
      if _from>_to then begin
         len:=0;
         exit;
      end;
      if _from=_to then begin
         len:=2;
         exit;
      end;
      if minlen[_from,_to]<>-1 then
         {nothing}
      else if br[_from] in [')',']'] then
         minlen[_from,_to]:=len(_from+1,_to)+2
      else if br[_to] in ['(','['] then
         minlen[_from,_to]:=len(_from,_to-1)+2
      else begin
         min:=300;
         for i:=_from to _to-1 do
            if len(_from,i)+len(i+1,_to)<min then
               min:=len(_from,i)+len(i+1,_to);
         if(br[_from]='(')and(br[_to]=')')or(br[_from]='[')and(br[_to]=']')then begin
            if len(_from+1,_to-1)+2<min then
               min:=len(_from+1,_to-1)+2;
         end;
         minlen[_from,_to]:=min;
      end;
      len:=minlen[_from,_to];
   end;

   function minstr(_from,_to:integer):string;
   var
      i:integer;
   begin
      if _from>_to then begin
         minstr:='';
         exit;
      end;
      if _from=_to then begin
         case br[_from] of
         '[',']':minstr:='[]';
         '(',')':minstr:='()';
         else
            writeln('Q');
            halt(1);
         end;
         exit;
      end;
      if br[_from]=']' then begin
         minstr:='[]'+minstr(_from+1,_to);
         exit;
      end;
      if br[_from]=')' then begin
         minstr:='()'+minstr(_from+1,_to);
         exit;
      end;
      if br[_to]='[' then begin
         minstr:=minstr(_from,_to-1)+'[]';
         exit;
      end;
      if br[_to]='(' then begin
         minstr:=minstr(_from,_to-1)+'()';
         exit;
      end;
      if (br[_from]='(') and (br[_to]=')') then begin
         if len(_from,_to)=len(_from+1,_to-1)+2 then begin
            minstr:='('+minstr(_from+1,_to-1)+')';
            exit;
         end;
      end;
      if (br[_from]='[') and (br[_to]=']') then begin
         if len(_from,_to)=len(_from+1,_to-1)+2 then begin
            minstr:='['+minstr(_from+1,_to-1)+']';
            exit;
         end;
      end;
      for i:=_from to _to-1 do begin
         if len(_from,_to)=len(_from,i)+len(i+1,_to) then begin
            minstr:=minstr(_from,i)+minstr(i+1,_to);
            exit;
         end;
      end;
      writeln('q');
      halt(2);
   end;

   procedure findminlen;
   var
      i,j:integer;
   begin
      for i:=1 to 100 do
         for j:=1 to 100 do
            minlen[i,j]:=-1;
      i:=len(1,n);
   end;

   procedure showminlen;
   begin
      assign(output,'bracket3.out');
      rewrite(output);
      write(minstr(1,n));
      close(output);
   end;

begin
   load;
   findminlen;
   showminlen;
end.