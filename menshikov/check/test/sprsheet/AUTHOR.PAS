{$M 64000,0,0}
type
  TCell = record
    known, visited: Boolean;
    v: Longint;
    expr: String;
  end;

var
  T: array ['A'..'Z', 1..9] of TCell;
  circRef: Boolean;

function CalcExpr(s: String): Longint; forward;

function CalcCell(r: String): Longint;
begin
  with T[r[1], ord(r[2]) - ord('0')] do begin
    if not known then begin
      if visited then begin circRef := true; exit; end;
      visited := true;
      v := CalcExpr(expr);
      known := true;
    end;
    CalcCell := v;
  end;
end;

function CalcExpr(s: String): Longint;
var
  p: Integer;
  cur: String;
  typ: (typConst, typRef, typAS, typMD, typL, typR, typEOF);

  procedure Next;
  begin
    while s[p] in [' ', #9] do Inc(p);
    cur := s[p]; Inc(p);
    case cur[1] of
    '+', '-': typ := typAS;
    '*', '/': typ := typMD;
    '(': typ := typL;
    ')': typ := typR;
    '$': typ := typEOF;
    '0'..'9': begin
      typ := typConst;
      while s[p] in ['0'..'9'] do begin
        cur := cur + s[p];
        Inc(p);
      end;
    end;
    'A'..'Z': begin
      typ := typRef;
      cur := cur + s[p];
      Inc(p);
    end;
    end;
  end;

  function Xpr: Longint; forward;

  function Fact: Longint;
  var
    r: Longint;
    t: Integer;
  begin
    case typ of
      typConst: Val(cur, r, t);
      typRef: r := CalcCell(cur);
      typL: begin
        Next;
        r := Xpr;
      end;
    end;
    Next;
    Fact := r;
  end;

  function Term: Longint;
  var
    r, f: Longint;
  begin
    r := Fact;
    while typ = typMD do begin
      if cur = '*' then begin
        Next; r := r * Fact;
      end else begin
        Next;
        f := Fact;
        if f = 0 then r := 0 else r := r div Fact;
      end;
    end;
    Term := r;
  end;

  function Xpr: Longint;
  var
    r: Longint;
  begin
    r := Term;
    while typ = typAS do
      if cur = '+' then begin Next; r := r + Term; end
                   else begin Next; r := r - Term; end;
    Xpr := r;
  end;

begin
  s := s + '$';
  p := 1;
  Next;
  CalcExpr := Xpr;

end;

var
  r: Char;
  c, i, j, N: Longint;
  S: String;
  f: Text;

begin
  for r := 'A' to 'Z' do
    for c := 1 to 9 do with T[r, c] do begin
      expr := '0';
      known := true;
      visited := false;
      v := 0;
    end;
  Assign(f, 'input.txt'); Reset(f);
  Readln(f, N);
  for i := 1 to N do begin
    Readln(f, S);
    for j := 1 to Length(S) do begin
      if S[j] in ['A'..'Z'] then r := S[j];
      if S[j] in ['1'..'9'] then c := ord(S[j]) - ord('0');
      if S[j] = '=' then begin
        T[r, c].expr := Copy(S, j+1, 255);
        T[r, c].known := false;
      end;
    end;
  end;
  Close(f);

  Assign(f, 'output.txt'); Rewrite(f);
  circRef := false;
  c := CalcCell('A1');
  if circRef then c := 1000000;
  Writeln(f, c);
  Close(f);
end.
