{
Written by Fyodor Menshikov 12.09.2003
22:48-23:31 (Accepted: +1)
}
type
   tarray=array[
      'A'..'C',
      'A'..'C',
      'A'..'C',
      'A'..'C',
      'A'..'C',
      'A'..'C',
      'A'..'C',
      'A'..'C',
      'A'..'C',
      'A'..'C'
   ] of boolean;
type
   rule=record
      from,
      into:string;
   end;
var
   a:array ['A'..'C','A'..'C']of ^tarray;
   original,current,cyclestart:string;
   rules:array[1..50]of rule;
   rulnum:integer;
   n:integer;

   procedure create;
   var
      c1,c2:char;
   begin
      for c1:='A' to 'C' do
         for c2:='A' to 'C' do
            new(a[c1,c2]);
   end;

   procedure clear;
   var
      c1,c2:char;
   begin
      for c1:='A' to 'C' do
         for c2:='A' to 'C' do
            fillchar(a[c1,c2]^,sizeof(tarray),0);
   end;

   procedure readstring(var s:string);{cuts spaces}
   var
      c:char;
   begin
      s:='';
      while not eoln do begin
         read(c);
         if c<>#32 then
            s:=s+c;
      end;
      readln;
   end;

   procedure load;
   var
      s:string;
      p:integer;
   begin
      readstring(s);
      original:=s;
      rulnum:=0;
      while not eof do begin
         readstring(s);
         p:=pos('->',s);
         if p=0 then begin
            if s='' then
               continue{one more eoln}
            else
               while true do;
         end;
         inc(rulnum);
         rules[rulnum].from:=copy(s,1,p-1);
         delete(s,1,p+1);
         rules[rulnum].into:=s;
         if length(rules[rulnum].from)<>length(rules[rulnum].into) then
            while true do;
      end;
      n:=length(original);
      while length(original)<12 do
         original:=original+'D';
   end;

   function place(var s:string):boolean;
   var
      i:integer;
   begin
      for i:=n+1 to 12 do
         s[i]:='A';
      place:=not a[s[1],s[2]]^[s[3],s[4],s[5],s[6],s[7],s[8],s[9],s[10],s[11],s[12]];
      a[s[1],s[2]]^
         [s[3],s[4],s[5],s[6],s[7],s[8],s[9],s[10],s[11],s[12]]:=true;
      for i:=n+1 to 12 do
         s[i]:='D';
   end;

var
   outcycle,incycle:longint;

   procedure step;
   var
      i,j,p:integer;
   begin
      for i:=1 to rulnum do begin
         p:=pos(rules[i].from,current);
         if p=0 then
            continue;
         dec(p);
         for j:=1 to length(rules[i].from) do
            current[p+j]:=rules[i].into[j];
         exit;
      end;
      writeln(outcycle,' 0');{all steps are acyclic}
      halt(0);
   end;

begin
   assign(input,'markovc.in');
   reset(input);
   assign(output,'markovc.out');
   rewrite(output);
   load;
   create;
   clear;
   current:=original;
   if place(current) then;
   outcycle:=0;
   while true do begin
      {writeln(current);}
      step;
      if not place(current) then
         break;{cycle start found}
      inc(outcycle);
   end;
   {writeln('repeat found:',current);}
   cyclestart:=current;
   incycle:=0;
   while true do begin
      step;
      {writeln(current);}
      inc(incycle);
      if current=cyclestart then
         break;
   end;
   writeln(outcycle-incycle+1,' ',incycle);
end.