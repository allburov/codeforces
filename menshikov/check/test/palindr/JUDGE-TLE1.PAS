{
Written by Fyodor Menshikov 13.01.2004
9:14-9:31
TL Ok for either 23 'A' or 24 different letters ('A'..'X')
I/O filename changed 21.01.2005
}
{-$define show}
var
   s:string;
   result:array[1..60]of char;
   used:array[0..60]of boolean;
   i,j,len:integer;
   count:longint;
   ok:boolean;
begin
   assign(input,'palindr.in');
   reset(input);
   assign(output,'palindr.out');
   rewrite(output);
   readln(s);
   for i:=0 to length(s) do
      used[i]:=false;
   len:=0;
   count:=0;
   repeat   
      {checking}
      if len>0 then begin
         i:=1;
         j:=len;
         ok:=true;
         while i<j do begin
            if result[i]<>result[j] then begin
               ok:=false;
               break;
            end;
            inc(i);
            dec(j);
         end;
         if ok then begin
            inc(count);
            {$ifdef show}
            write('>');
            for i:=1 to length(s) do
               if used[i] then
                  write(s[i])
               else
                  write('-');
            writeln;
            {$endif}
         end;
      end;
      {next used}
      i:=length(s);
      while used[i] do begin
         used[i]:=false;
         dec(i);
         dec(len);{cutting symbol in the end}
      end;
      used[i]:=true;
      inc(len);
      result[len]:=s[i];{on last pass ":=s[0]"}
   until used[0];
   writeln(count);
end.