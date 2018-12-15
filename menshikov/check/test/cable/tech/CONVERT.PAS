{
Converts input and output data of NEERC2001 "Cable" problem
fixed->int
}
{$R+,Q+,N+,E-}

   procedure incstr(var s:string);
   var{does not work when number length enlargement required}
      i:integer;
   begin
      i:=length(s);
      while s[i]='9' do begin
         s[i]:='0';
         dec(i);
      end;
      inc(s[i]);
   end;

var
   ext:string;
   i,j,n:integer;
   k:longint;
   a:array[1..10000]of longint;
   r:extended;
begin
   ext:='00';
   for i:=1 to 13 do begin
      incstr(ext);
      assign(input,'cable.'+ext);
      reset(input);
      readln(n,k);
      for j:=1 to n do begin
         readln(r);
         a[j]:=round(r*100);
      end;
      close(input);
      assign(output,'cable.'+ext);
      rewrite(output);
      writeln(n,' ',k);
      for j:=1 to n do
         writeln(a[j]);
      close(output);
      assign(input,'cable.'+ext+'a');
      reset(input);
      readln(r);
      close(input);
      assign(output,'cable.'+ext+'a');
      rewrite(output);
      writeln(r*100:0:0);
      close(output);
   end;
end.