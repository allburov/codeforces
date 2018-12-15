{
Written by Fyodor Menshikov 02.08.2002
Internal error format modified 12.01.2004
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
      while true do;
   end;

const
   wall=1;
   space=2;
   origin=3;
   way=4;
   p1_0=5;
   m1_0=6;
   _0p1=7;
   _0m1=8;
type
   queue=array[1..250*250]of byte;
var
   qx,qy:^queue;
   first,last:word;

   procedure add_queue(x,y:byte);
   begin
      inc(last);
      qx^[last]:=x;
      qy^[last]:=y;
   end;

   procedure get_queue(var x,y:byte);
   begin
      x:=qx^[first];
      y:=qy^[first];
      inc(first);
   end;

   function not_empty:boolean;
   begin
      not_empty:=first<=last;
   end;

var
   n:integer;
   a:array[0..251,0..251]of byte;
   destx,desty:integer;

   procedure read_data;
   var
      i,j:integer;
      c:char;
   begin
      assign(input,'lines2.in');
      reset(input);
      readln(n);
      for i:=0 to n+1 do
         for j:=0 to n+1 do
            a[i,j]:=wall;
      for i:=1 to n do begin
         for j:=1 to n do begin
            read(c);
            case c of
            '.':a[i,j]:=space;
            'O':a[i,j]:=wall;
            '@':begin
               a[i,j]:=origin;
               add_queue(i,j);
            end;
            'X':begin
               a[i,j]:=space;
               destx:=i;
               desty:=j;
            end;
            else
               ie('unknown symbol in input');
            end;
         end;
         readln;
      end;
   end;

   procedure first_step;
   var
      x,y:byte;
   begin
      while not_empty do begin
         get_queue(x,y);
         if a[x+1,y]=space then begin
            a[x+1,y]:=p1_0;
            add_queue(x+1,y);
         end;
         if a[x-1,y]=space then begin
            a[x-1,y]:=m1_0;
            add_queue(x-1,y);
         end;
         if a[x,y+1]=space then begin
            a[x,y+1]:=_0p1;
            add_queue(x,y+1);
         end;
         if a[x,y-1]=space then begin
            a[x,y-1]:=_0m1;
            add_queue(x,y-1);
         end;
      end;
   end;

var
   possible:boolean;
   waylen:longint;

   procedure second_step;
   var
      x,y:byte;
   begin
      if a[destx,desty]=space then
         possible:=false
      else begin
         possible:=true;
         waylen:=0;
         x:=destx;
         y:=desty;
         while true do begin
            case a[x,y] of
            p1_0:x:=x-1;
            m1_0:x:=x+1;
            _0p1:y:=y-1;
            _0m1:y:=y+1;
            origin:
               break;
            else
               ie('unknown direction while solving');
            end;
            inc(waylen);
         end;
      end;
      for x:=1 to n do
         for y:=1 to n do
            case a[x,y] of
            p1_0,m1_0,_0p1,_0m1:a[x,y]:=space;
            end;
   end;

   procedure check;
   type
      tUserField=array[0..251,0..251]of char;
   var
      u:^tUserField;

      function neighbour_plus(i,j:integer):integer;
      var
         sum:integer;
      begin
         sum:=0;
         if u^[i+1,j]='+' then
            inc(sum);
         if u^[i-1,j]='+' then
            inc(sum);
         if u^[i,j+1]='+' then
            inc(sum);
         if u^[i,j-1]='+' then
            inc(sum);
         neighbour_plus:=sum;
      end;

   var
      answer:string;
      i,j:integer;
      c:char;
      ii,jj:integer;
      count:longint;
   begin
      assign(input,'lines2.out');
      reset(input);
      if eoln then
         pe;
      read(answer);
      if not eoln then
         pe;
      readln;
      if answer='N' then begin
         if not eof then
            pe;
         if not possible then
            ac
         else
            wa;
      end;
      if answer<>'Y' then
         pe;
      new(u);
      for i:=0 to 251 do
         for j:=0 to 251 do
            u^[i,j]:='.';
      for i:=1 to n do begin
         for j:=1 to n do begin
            if eoln then
               pe;
            read(c);
            if c in ['.','O','+','@'] then
               u^[i,j]:=c
            else
               pe;
         end;
         if not eoln then
            pe;
         readln;
      end;
      if not eof then
         pe;
      for i:=1 to n do
         for j:=1 to n do begin
            if (a[i,j]=origin)xor(u^[i,j]='@') then
               pe;
            if (a[i,j]=wall)xor(u^[i,j]='O') then
               pe;
            if (a[i,j] in [way,space])xor(u^[i,j] in ['.','+']) then
               pe;
         end;
      for i:=1 to n do
         for j:=1 to n do
            if u^[i,j]='@' then begin
               ii:=i;
               jj:=j;
            end;
      count:=0;
      while true do begin
         case neighbour_plus(ii,jj) of
         0:break;
         1:begin
            inc(count);
            u^[ii,jj]:='.';
            if u^[ii+1,jj]='+' then
               inc(ii)
            else if u^[ii-1,jj]='+' then
               dec(ii)
            else if u^[ii,jj+1]='+' then
               inc(jj)
            else if u^[ii,jj-1]='+' then
               dec(jj)
            else
               ie('there is plus near, but not in 4 neighbour squares');
            u^[ii,jj]:='@';
         end;
         else
            pe;
         end;
      end;
      for i:=1 to n do
         for j:=1 to n do
            if u^[i,j]='+' then
               pe;
      if (ii<>destx)or(jj<>desty) then
         pe;
      if count<>waylen then
         wa;
      ac;
   end;

begin
   new(qx);
   new(qy);
   first:=1;
   last:=0;
   read_data;
   first_step;
   second_step;
   check;
end.