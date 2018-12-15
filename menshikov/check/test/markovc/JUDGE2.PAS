{
Written by Fyodor Menshikov 20.08.2004
16:22-16:34
}
var
   rules:array[1..50]of record
      len:integer;
      from,into:string;
   end;
   numRules:integer;
   steps:longint;

   procedure killSpaces(var s:string);
   var
      p:integer;
   begin
      while true do begin
         p:=pos(' ',s);
         if p=0 then
            exit;
         delete(s,p,1);
      end;
   end;

   procedure split(s:string;var start,finish:string);
   var
      p:integer;
   begin
      p:=pos('->',s);
      if p=0 then
         halt(1);
      start:=copy(s,1,p-1);
      delete(s,1,p+1);
      finish:=s;
   end;

   procedure step(var s:string);
   var
      i,j,p:integer;
   begin
      for i:=1 to numRules do begin
         p:=pos(rules[i].from,s);
         if p=0 then
            continue;
         for j:=1 to length(rules[i].from) do
            s[p+j-1]:=rules[i].into[j];
         exit;
      end;
      writeln(steps,' ',0);
      halt;
   end;

var
   s,s0,s1,t:string;
   steps1,cycle:longint;
begin
   assign(input,'markovc.in');
   reset(input);
   assign(output,'markovc.out');
   rewrite(output);
   readln(s0);
   killSpaces(s0);
   numRules:=0;
   while not eof do begin
      readln(t);
      killSpaces(t);
      inc(numRules);
      split(t,rules[numRules].from,rules[numRules].into);
      rules[numRules].len:=length(rules[numRules].from);
   end;
   s:=s0;
   steps:=0;
   repeat
      step(s);
      inc(steps);
   until steps=53144;
   s1:=s;
   steps1:=steps;
   repeat
      step(s);
      inc(steps);
   until s=s1;
   cycle:=steps-steps1;
   while steps mod cycle<>0 do begin
      step(s);
      inc(steps);
   end;
   steps:=0;
   while s<>s0 do begin
      step(s);
      step(s0);
      inc(steps);
   end;
   writeln(steps,' ',cycle);
end.