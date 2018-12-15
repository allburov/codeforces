{
Written by Fyodor Menshikov 18.04.2004
}
   procedure ac;
   begin
      writeln('a');
      halt(0);
   end;

   procedure wa;
   begin
      writeln('wa');
      halt(1);
   end;

   procedure pe;
   begin
      writeln('pe');
      halt(2);
   end;

   procedure ie(message:string);
   begin
      writeln('Internal error: ',message);
      readln;
      halt;
   end;

   procedure usage;
   begin
      writeln('Usage: enum filename.out filename.chk path\to\answers.txt');
      readln;
      halt;
   end;

var
   out,chk,lst:text;
   judge_answer,user_answer,s:string;
   found:boolean;
begin
   if paramcount<>3 then
      usage;
   assign(out,paramstr(1));
   assign(chk,paramstr(2));
   assign(lst,paramstr(3));
   {$I-}
   reset(out);
   {$I+}
   if ioresult<>0 then
      ie('cannot open contestant output '+paramstr(1));
   {$I-}
   reset(chk);
   {$I+}
   if ioresult<>0 then
      ie('cannot open judge output '+paramstr(2));
   {$I-}
   reset(lst);
   {$I+}
   if ioresult<>0 then
      ie('cannot open possible answers list '+paramstr(3));
   {checking format of possible answers file}
   if eof(lst) then
      ie('possible answers file has wrong format');
   while not eof(lst) do begin
      read(lst,s);
      if s='' then
         ie('possible answers file has wrong format');
      if not eoln(lst) then
         ie('possible answers file has wrong format');
      readln(lst);
   end;
   close(lst);
   reset(lst);
   {checking format of judge answer}
   if eoln(chk) then
      ie('judge answer has wrong format');
   read(chk,judge_answer);
   if not eoln(chk) then
      ie('judge answer has wrong format');
   readln(chk);
   if not eof(chk) then
      ie('judge answer has wrong format');
   found:=false;
   while not eof(lst) do begin
      readln(lst,s);
      if s=judge_answer then
         found:=true;
   end;
   if not found then
      ie('judge answer absent in list');
   close(lst);
   reset(lst);
   {checking format of user answer}
   if eoln(out) then
      pe;
   read(out,user_answer);
   if not eoln(out) then
      pe;
   readln(out);
   if not eof(out) then
      pe;
   found:=false;
   while not eof(lst) do begin
      readln(lst,s);
      if s=user_answer then
         found:=true;
   end;
   if not found then
      pe;
   {comparing}
   if user_answer=judge_answer then
      ac
   else
      wa;
end.