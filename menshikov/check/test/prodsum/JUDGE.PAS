{
Written by Fyodor Menshikov 20.08.2004
11:05-11:25
}
{$R+,Q+}
type
   integer=longint;
var
   n,s,count,z,a,b,c,d,p,sqrtd:integer;
begin
   assign(input,'prodsum.in');
   reset(input);
   assign(output,'prodsum.out');
   rewrite(output);
   readln(n,s);
   count:=0;
   for z:=0 to n do begin
      {s=p(p-1)/2-p(n-z-p)+(n-z-p)(n-z-p-1)/2}
      {2s=p(p-1)-2p(n-z-p)+(n-z-p)(n-z-p-1)}
      {2s=p^2-p -2pn+2pz+2p^2 +n^2-nz-np-n-zn+z^2+zp+z-pn+pz+p^2+p}
      {2s=p^2+2p^2+p^2 -p-2pn+2pz-np+zp+pz-pn+p +n^2-nz-n-zn+z^2+z}
      {4p^2 +4(z-n)p +z^2+n^2-2nz+z-n-2s=0}
      a:=4;
      b:=4*(z-n);
      c:=z*z+n*n-2*n*z+z-n-2*s;
      d:=b*b-4*a*c;
      if (d>=0)and(sqr(round(sqrt(d)))=d) then begin
         sqrtd:=round(sqrt(d));
         if (-b+sqrtd) mod (2*a)=0 then begin
            p:=(-b+sqrtd) div (2*a);
            if (0<=p)and(p<=n-z) then begin
               inc(count);
               {writeln('+ z=',z,' p=',p);}
               continue;
            end;
         end;
         if (-b-sqrtd) mod (2*a)=0 then begin
            p:=(-b-sqrtd) div (2*a);
            if (0<=p)and(p<=n-z) then begin
               inc(count);
               {writeln('- z=',z,' p=',p);}
               continue;
            end;
         end;
      end;
   end;
   writeln(count);
end.