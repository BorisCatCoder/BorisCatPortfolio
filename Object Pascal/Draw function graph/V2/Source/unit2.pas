unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Unit3,Grids;

  procedure InitX(var s:TMas;a,b:real; n:integer);
procedure InitF(var y:TMas; f:TFunction; M:TMas);
procedure df(x:TMas;var res:TMas; f:TFunction);
procedure d2f(x:TMas; var res:TMas; f:TFunction);
procedure OutInGrid(var Grid:TStringGrid; M:TMas; n:integer);
procedure getRoot(f: TFunction; x: TMas; var res: TMas);
procedure getRoots(f: TFunction; x: TMas; var r: TMas);
procedure getExt(f: TFunction; x: TMas; var r: TMas);
procedure Integral(f: TFunction; x: TMas; var res: TMas);

implementation
function min(a,b:real):real;
    begin
      result:=a;
      if b<a then result:=b;

      end;
    function Max(a,b:integer):integer;
    begin
       result:=a;
      if b>a then result:=b;

    end;

    procedure OutInGrid(var Grid:TStringGrid; M:TMas; n:integer);
    var
      i:integer;
    begin
     if Grid.RowCount<length(M)+2 then Grid.RowCount:= length(M)+1;
            for i:=Low(M) to High(M) do
            begin
                 Grid.Cells[n,i+1]:=FloatToStr(M[i]);
            end;
    end;

    procedure InitX(var s:TMas;a,b:real; n:integer);
    var
      i:integer;
      x,dx:real;
    begin
      SetLength(s,n+1);
      dx:=abs(b-a)/n;
      x:=min(a,b);
      for i:=0 to n-1 do
      begin
         s[i]:=x+i*dx;
        end;
      s[high(s)]:=b;

      end;
    procedure InitF(var y:TMas; f:TFunction; M:TMas);
    var
      i:integer;

    begin
      SetLength(y,length(M));
      for i:=Low(y) to High(y) do
      begin
           y[i]:=f(M[i]);
         end;
      end;


    procedure df(x:TMas;var res:TMas; f:TFunction);
    var
      i:integer;
    begin
      SetLength(res,length(x));
        res[0]:=(f(x[1])-f(x[0]))/(x[1]-x[0]);
      for i:=Low(x)+1 to high(x)-1 do
         res[i]:=(f(x[i+1])-f(x[i-1]))/(x[i+1]-x[i-1]);
      res[i+1]:=(f(x[i+1])-f(x[i]))/(x[i+1]-x[i]);
    end;

    procedure d2f(x:TMas; var res:TMas; f:TFunction);
   var i: integer;
   begin
     SetLength(res,length(x));
      res[0]:=(f(x[2])-2*f(x[1])+f(x[0]))/sqrt(x[1]-x[0]);
      for i:=Low(x)+1 to high(x)-1 do
         res[i]:=(f(x[i+1])-2*f(x[i])+f(x[i-1]))/sqrt(x[i]-x[i-1]);
      res[i+1]:=(f(x[i+1])-2*f(x[i])+f(x[i-1]))/sqrt(x[i+1]-x[i]);
    end;


     procedure getRoot(f: TFunction; x: TMas; var res: TMas);
   var a, b, xR: real;
       i, l: integer;
       const e=1E-6;
   begin
      l:=0;
      if f(x[0])=0 then
      begin
         inc(l);
         setLength(res, l);
         res[l-1]:=x[0];
      end;
      if f(x[high(x)])=0 then
      begin
         inc(l);
         setLength(res, l);
         res[l-1]:=x[high(x)];
      end;
      for i:=0 to high(x)-1 do
         if f(x[i])*f(x[i+1])<0 then
         begin
            a:=x[i];
            b:=x[i+1];
            while b-a>2*e do
            begin
               xR:=(a+b)/2;
               if f(xR)=0 then
                  break;
               if f(a)*f(xR)<0 then
                  b:=xR
               else
                  a:=xR;
            end;
            inc(l);
            setLength(res, l);
            res[l-1]:=xR;
         end;
   end;

function NulExist (f:TFunction; a,b:real):boolean;
 var
  i:integer;
 begin
     result:=false;
     if (f(a)>0) and (f(b)<0) then result:=true;
     if (f(b)<0) and (f(a)>0) then result:=true;
     if (f(b)=0) or (f(a)=0) then result:=true;
 end;

 procedure getRoots(f: TFunction; x: TMas; var r: TMas);
var a, b, xR,f1,f2: real;
i, l: integer;
const eps=1E-10;
  procedure add(xx:real);
  begin
     if (l=0) or (abs(r[l-1]-xx)>8*eps) then
     begin
       inc(l);setlength(r,l);r[l-1]:=xx;
     end;
  end;

begin
  l:=0;
  if f(x[high(x)])=0 then add(x[high(x)]);
  for i:=0 to high(x)-1 do
  begin
    f1:=f(x[i]);
    f2:=f(x[i+1]);
    if abs(f1)<eps then add(x[i]);
    if (f1<0) xor (f2<0) then
    begin
      a:=x[i];
      b:=x[i+1];
      while b-a>2*eps do
      begin
        xR:=(a+b)/2;
        if f(xR)=0 then break;
        if (f(a)<0) xor (f(xR)<0) then
            b:=xR
        else
            a:=xR;
      end;
      add(xR);
    end;
  end;
end;


  procedure getExt(f: TFunction; x: TMas; var r: TMas);
   var i, l: integer;
   begin
      l:=0;
      for i:=1 to high(x)-1 do
      begin
         if ((f(x[i])>f(x[i-1])) and (f(x[i])>f(x[i+1]))) or ((f(x[i])<f(x[i-1])) and (f(x[i])<f(x[i+1]))) then
         begin
            inc(l);
            setLength(r, l);
            r[l-1]:=x[i];
         end;
      end;
   end;

  procedure Integral(f: TFunction; x: TMas; var res: TMas);
   var i: integer;
   sum:real;
   begin
     SetLength(res,length(x));
      res[0]:=0;
      for i:=1 to high(x) do
         res[i]:=res[i-1]+(f(x[i])+f(x[i-1]))*(x[i]-x[i-1])/2;
      //sum:=0;
      //for i:=Low(res) to High(res) do
      //  sum:=sum+res[i];
      //
      //res[high(res)]:=sum;
      //result:=sum;
   end;

end.

