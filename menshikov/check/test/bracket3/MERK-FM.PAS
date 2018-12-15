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
            exit;{просто скинуть весь стек - уже не будет лучше, чем есть}
         {вся исходная строка просмотрена}
         {и при этом currentPtr + stackPtr < resultLen}
         {скидываем стек}
         while stackPtr > 0 do begin
            inc(currentPtr);
            current[currentPtr] := stack[stackPtr].bracket;
            dec(stackPtr);
         end;
         {сохраняем результат}
         current[0] := chr(currentPtr);
         result := current;
         exit;
      end;
      if source[sourcePtr] = '(' then begin
         inc(currentPtr);
         current[currentPtr] := '(';
         inc(stackPtr);
         stack[stackPtr].bracket := ')';{чем придётся закрывать}
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
      {рассматриваемая скобка - закрывающая}
      if stackPtr = 0 then begin
         {стека пуст - нужно вписывать открывающую}
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
      {рассматриваемая скобка - закрывающая}
      {стек не пуст, и вершина стека совпадает с текущей - Ok}
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
      {рассматриваемая скобка - закрывающая}
      {стек не пуст, и вершина не совпадает с текущей}
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
      {вариант 1: написать открывающую специально для встретившейся закрывающей}
      inc(currentPtr);
      current[currentPtr] := OB;
      inc(currentPtr);
      current[currentPtr] := CB;
      oldStackItem := stack[stackPtr];
      stack[stackPtr].closeByActual := true;{признак того, что с другими поступать так же}
      Go(sourcePtr + 1,stackPtr,currentPtr);
      stack[stackPtr] := oldStackItem;
      dec(currentPtr);
      dec(currentPtr);
      oldStackPtr := stackPtr;
      {вариант 2: закрыть все открытые не того типа}
      while true do begin
         if stackPtr = 0 then
            exit;{стек перебран - не было таких открывающих}
         if stack[stackPtr].bracket = CB then
            break;{нашли}
         if stack[stackPtr].closeByActual then
            exit;{эта скобка должна быть закрыта настоящей}
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