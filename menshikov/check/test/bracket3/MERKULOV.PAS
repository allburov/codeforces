{$A+,B-,D-,E-,F-,G+,I-,L-,N+,O-,P-,Q-,R-,S-,T-,V-,X-,Y-}
{$M 65500,0,655360}
program C5 ;
type
   bbuuff = array [0..110] of char ;
   ggg    = array [0..110] of boolean ;
var
   i, j, n, maxi  : integer ;
   a, b           : bbuuff ;
   s, max         : array [1..200] of char ;
   c              : char ;
   g              : ggg ;
   ya             : string ;
   o              : bbuuff absolute ya ;
procedure Go(g : ggg ; b : bbuuff ; aa,bb,ss,nkr,nkv : integer) ;
var
   now : boolean ;
begin
   inc(aa) ;
   if ss + bb = maxi then exit ;
   if aa > n then begin
      for i := 1 to bb do s[ss+i] := b[bb+1-i] ;
      ss := ss + bb ;
      maxi := ss ;
      max := s ;
      exit ;
   end ;
   if a[aa] = '(' then begin
      inc(bb) ;
      inc(ss) ;
      inc(nkr) ;
      b[bb] := ')' ;
      s[ss] := '(' ;
      Go(g,b,aa,bb,ss,nkr,nkv) ;
      exit ;
   end ;
   if a[aa] = '[' then begin
      inc(bb) ;
      inc(ss) ;
      inc(nkv) ;
      b[bb] := ']' ;
      s[ss] := '[' ;
      Go(g,b,aa,bb,ss,nkr,nkv) ;
      exit ;
   end ;
   if (bb = 0) or (a[aa] = b[bb]) then begin
      inc(ss) ;
      if bb = 0 then begin
         if a[aa] = ')' then s[ss] := '('
         else s[ss] := '[' ;
         inc(ss) ;
         s[ss] := a[aa] ;
      end
      else begin
         g[bb] := false ;
         if b[bb] = ')' then dec(nkr)
         else dec(nkv) ;
         s[ss] := a[aa] ;
         dec(bb) ;
      end ;
      Go(g,b,aa,bb,ss,nkr,nkv) ;
      exit ;
   end ;
   if a[aa] = ')' then begin
      inc(ss) ;
      s[ss] := '(' ;
      s[ss+1] := ')' ;
      now := g[bb] ;
      g[bb] := true ;
      Go(g,b,aa,bb,ss+1,nkr,nkv) ;
      g[bb] := false ;
      if (nkr > 0) and not now then begin
         repeat
            s[ss] := ']' ;
            dec(bb) ;
            inc(ss) ;
            dec(nkv) ;
            if g[bb] and (b[bb] = ']') then exit ;
         until (b[bb] = ')') ;
         s[ss] := ')' ;
         if nkr > 0 then dec(nkr) ;
         g[bb] := false ;
         if bb > 0 then dec(bb) ;
         Go(g,b,aa,bb,ss,nkr,nkv) ;
      end ;
   end
   else begin
      inc(ss) ;
      s[ss] := '[' ;
      s[ss+1] := ']' ;
      now := g[bb] ;
      g[bb] := true ;
      Go(g,b,aa,bb,ss+1,nkr,nkv) ;
      g[bb] := false ;
      if (nkv > 0) and not now then begin
         repeat
            s[ss] := ')' ;
            dec(bb) ;
            inc(ss) ;
            dec(nkr) ;
            if g[bb] and (b[bb] = ')') then exit ;
         until (b[bb] = ']') ;
         s[ss] := ']' ;
         if nkv > 0 then dec(nkv) ;
         g[bb] := false ;
         if bb > 0 then dec(bb) ;
         Go(g,b,aa,bb,ss,nkr,nkv) ;
      end ;
   end ;
end ;
begin
   assign(input,'bracket3.in') ;
   assign(output,'bracket3.out') ;
   ya := '([([()[[()[()()]]]])])[[()(())]]]' ;
   ya[0] := '[' ;
   reset(input) ;
   rewrite(output) ;
   if eoln then exit ;
   repeat
      inc(n) ;
      read(c) ;
      a[n] := c ;
   until eoln ;
   maxi := 205 ;
   Go(g,b,0,0,0,0,0) ;
   for i := 1 to maxi do write(max[i]) ;
   close(output)
end .