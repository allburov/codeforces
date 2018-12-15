{
  Летние сборы по информатике '2000
  Проверяющая программа
  Задача: QuickSort
  Автор:  Владимир Мартьянов
}

{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V-,X+,Y+}
{$M 16384,0,655360}

uses TestLib{, Symbols};

const BankSize = 1000;

type TArr = array [0..BankSize-1] of longint;
     Parr = ^TArr;

var m: array [0..1000] of PArr;
    n, i, j: longint;

procedure ReadData;
var i: longint;
begin
  n := inf. ReadLongint;
  for i := 0 to (n div BankSize) do new (m[i]);
  for i := 1 to n do
    m[i div BankSize]^[i mod BankSize] := ouf. ReadLongint;
end;

procedure mSwap (x, y: longint);
var tmp: longint;
begin
  tmp := m[x div BankSize]^[x mod BankSize];
  m[x div BankSize]^[x mod BankSize] := m[y div BankSize]^[y mod BankSize];
  m[y div BankSize]^[y mod BankSize] := tmp;
end;

procedure TestIt;
var l, r, k, q: longint;
begin
  l := 1; r := n;
  while l <> r do
  begin
  k := (r+l) div 2;
  q := m[k div BankSize]^[k mod BankSize];
  if (q <> l) and (q <> r) then
    quit(_wa,'');
  if (r-l) = 1 then
     if q = r then quit(_wa,'');
  if (r-l) = 3 then
     if q = l then quit(_wa,'');

  if (q = l) then
      begin
        mSwap (l, k);
        inc (l);
      end else
  if (q = r) then
      begin
        mSwap (r, k);
        dec (r);
      end;
  end;
end;

begin
  if n <> 700000 then
    begin
      ReadData;
      TestIt;
    end;
  quit(_ok, '');
end.
