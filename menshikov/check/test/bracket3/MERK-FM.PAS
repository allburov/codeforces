{
From Alexander Merkulov's program
Modified by Fyodor Menshikov 05.09.2004
}
{-$R+,Q+}
type
   TStackItem = record
      bracket       : char;
      closeByActual : boolean;
   end;
   TStack = array [1..100] of TStackItem;
var
   source, current, result : string;
   stack                   : TStack;

   procedure Go(sourcePtr,stackPtr,currentPtr : integer);
   var
      oldStackItem : TStackItem;
      oldStackPtr  : integer;
      AB, CB, OB   : char;
   begin
      if sourcePtr > length(source) then begin
         if currentPtr + stackPtr >= length(result) then {FM: '=' -> '>='}
            exit;{���� ᪨���� ���� �⥪ - 㦥 �� �㤥� ����, 祬 ����}
         {��� ��室��� ��ப� ��ᬮ�७�}
         {� �� �⮬ currentPtr + stackPtr < resultLen}
         {᪨�뢠�� �⥪}
         while stackPtr > 0 do begin
            inc(currentPtr);
            current[currentPtr] := stack[stackPtr].bracket;
            dec(stackPtr);
         end;
         {��࠭塞 १����}
         current[0] := chr(currentPtr);
         result := current;
         exit;
      end;
      if source[sourcePtr] = '(' then begin
         inc(currentPtr);
         current[currentPtr] := '(';
         inc(stackPtr);
         stack[stackPtr].bracket := ')';{祬 �ਤ���� ����뢠��}
         stack[stackPtr].closeByActual := false;
         Go(sourcePtr + 1,stackPtr,currentPtr);
         exit;
      end;
      if source[sourcePtr] = '[' then begin
         inc(currentPtr);
         current[currentPtr] := '[';
         inc(stackPtr);
         stack[stackPtr].bracket := ']';
         stack[stackPtr].closeByActual := false;
         Go(sourcePtr + 1,stackPtr,currentPtr);
         exit;
      end;
      {��ᬠ�ਢ����� ᪮��� - ����뢠���}
      if stackPtr = 0 then begin
         {�⥪� ���� - �㦭� ����뢠�� ���뢠����}
         inc(currentPtr);
         if source[sourcePtr] = ')' then
            current[currentPtr] := '('
         else
            current[currentPtr] := '[';
         inc(currentPtr);
         current[currentPtr] := source[sourcePtr];
         Go(sourcePtr + 1,stackPtr,currentPtr);
         exit;
      end;
      {��ᬠ�ਢ����� ᪮��� - ����뢠���}
      {�⥪ �� ����, � ���設� �⥪� ᮢ������ � ⥪�饩 - Ok}
      if source[sourcePtr] = stack[stackPtr].bracket then begin
         inc(currentPtr);
         current[currentPtr] := source[sourcePtr];
         oldStackItem := stack[stackPtr];
         dec(stackPtr);
         Go(sourcePtr + 1,stackPtr,currentPtr);
         inc(stackPtr);
         stack[stackPtr] := oldStackItem;
         exit;
      end;
      {��ᬠ�ਢ����� ᪮��� - ����뢠���}
      {�⥪ �� ����, � ���設� �� ᮢ������ � ⥪�饩}
      if source[sourcePtr] = ')' then begin
         CB := ')';{close}
         OB := '(';{open}
         AB := ']';{another}
      end
      else if source[sourcePtr] = ']' then begin
         CB := ']';
         OB := '[';
         AB := ')';
      end
      else
         halt(1);
      {��ਠ�� 1: ������� ���뢠���� ᯥ樠�쭮 ��� ����⨢襩�� ����뢠�饩}
      inc(currentPtr);
      current[currentPtr] := OB;
      inc(currentPtr);
      current[currentPtr] := CB;
      oldStackItem := stack[stackPtr];
      stack[stackPtr].closeByActual := true;{�ਧ��� ⮣�, �� � ��㣨�� ����㯠�� ⠪ ��}
      Go(sourcePtr + 1,stackPtr,currentPtr);
      stack[stackPtr] := oldStackItem;
      dec(currentPtr);
      dec(currentPtr);
      oldStackPtr := stackPtr;
      {��ਠ�� 2: ������� �� ������ �� ⮣� ⨯�}
      while true do begin
         if stackPtr = 0 then
            exit;{�⥪ ��ॡ࠭ - �� �뫮 ⠪�� ���뢠���}
         if stack[stackPtr].bracket = CB then
            break;{��諨}
         if stack[stackPtr].closeByActual then
            exit;{�� ᪮��� ������ ���� ������ �����饩}
         dec(stackPtr);
         inc(currentPtr);
         current[currentPtr] := AB;
      end;
      inc(currentPtr);
      current[currentPtr] := CB;
      oldStackItem := stack[stackPtr];
      dec(stackPtr);
      Go(sourcePtr + 1,stackPtr,currentPtr);
      inc(stackPtr);
      stack[stackPtr] := oldStackItem;
      while stackPtr < oldStackPtr do begin
         inc(stackPtr);
         stack[stackPtr].bracket := AB;
         stack[stackPtr].closeByActual := false;
      end;
   end;

begin
   assign(input,'bracket3.in');
   assign(output,'bracket3.out');
   reset(input);
   rewrite(output);
   if eoln then exit;
   readln(source);
   result[0] := chr(length(source) * 2 + 1);
   Go(1,0,0);
   write(result);
end .