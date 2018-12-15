{
Written by Fyodor Menshikov 19.08.2004
20:39-20:57 using solution
}
const
   len3 = 8; {размер множества}
   {из соображений экономии памяти должен быть кратен 8}

   len2 = 1024; {размер массива из множеств}
   {для повышения скорости работы должен быть степенью двойки}

   len1 = 65; {размер массива из указателей на массивы из множеств}
   {должно выполняться: len1 * len2 * len3 >= 3^12 = 531 441}

type
   arr = array [0..len2 - 1] of set of 0..len3 - 1;
   {указатель можно объявить только на тип, имеющий имя}

var
   table: array [0..len1 - 1] of ^arr;

   function was(index: longint): boolean;
   var
      index1, index2, index3: integer;
   begin
      index3 := index mod len3;
      index2 := index div len3 mod len2;
      index1 := index div len3 div len2; {mod len1}
      was := index3 in table[index1]^[index2];
   end;

   procedure put(index: longint);
   var
      index1, index2, index3: integer;
   begin
      index3 := index mod len3;
      index2 := index div len3 mod len2;
      index1 := index div len3 div len2; {mod len1}
      include(table[index1]^[index2], index3);
   end;

   procedure initTable;
   var
      index1, index2: integer;
   begin
      for index1 := 0 to len1 - 1 do begin
         new(table[index1]);
         for index2 := 0 to len2 - 1 do
            table[index1]^[index2] := []; {пустое множество}
      end;
   end;

   function encode(s: string): longint;
   var
      i: integer;
      result: longint;
   begin
      result := 0;
      for i := 1 to length(s) do
         result := result * 3 + (ord(s[i]) - ord('A'));
      encode := result;
   end;

   procedure delSpaces(var s:string);
   begin
      while pos(' ',s)>0 do
         delete(s,pos(' ',s),1);
   end;

var
   rules:array[1..50]of record
      left,right:string;
   end;
   numRules:integer;
   steps:longint;

   procedure step(var s:string);
   var
      i,p:integer;
   begin
      for i:=1 to numRules do begin
         p:=pos(rules[i].left,s);
         if p>0 then begin
            delete(s,p,length(rules[i].left));
            insert(rules[i].right,s,p);
            exit;
         end;
      end;
      writeln(steps,' ',0);
      halt;
   end;
var
   s,s0,t,sc:string;
   cyclic:longint;
begin
   assign(input,'markovc.in');
   reset(input);
   assign(output,'markovc.out');
   rewrite(output);
   readln(s0);
   delSpaces(s0);
   numRules:=0;
   while not eof do begin
      readln(t);
      delSpaces(t);
      inc(numRules);
      rules[numRules].left:=copy(t,1,pos('->',t)-1);
      delete(t,1,pos('->',t)+1);
      rules[numRules].right:=t;
   end;
   initTable;
   s:=s0;
   steps:=0;
   repeat
      put(encode(s));
      step(s);
      inc(steps);
   until was(encode(s));
   sc:=s;
   cyclic:=0;
   repeat
      step(s);
      inc(cyclic);
   until s=sc;
   writeln(steps-cyclic,' ',cyclic);
end.