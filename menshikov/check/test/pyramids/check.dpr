program checkb;

uses
    testlib, sysutils;

var
    d1, d2: extended;

begin
    d1 := ans.readReal;
    d2 := ouf.readReal;

    if abs(d1 - d2) > 1.1e-4 then begin
        quit(_wa, 'Expected "' + floattostr(d1) + '", found "' + floattostr(d2) + '"');
    end;

    quit(_ok, '');
end.