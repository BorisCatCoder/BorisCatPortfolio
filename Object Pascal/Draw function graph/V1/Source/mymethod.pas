unit MyMethod;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,MyFunc,Grids;

  procedure OutInStringGrid(var grid:TStringGrid;n:integer; Mas:TMas);
  function DebufOut (Mas:TMas):string;
  procedure getX(a, b: real; n: integer; var r: TMas);
    procedure GetY (f:TFunction; MasX:TMas; var MasY:TMas);
     function NulExist (f:TFunction; a,b:real):boolean;
     function getInt(x,y: TMas):real;
      procedure getFD(f: TFunction; x: TMas; var r: TMas);
      procedure d2F(f:TFunction;n:Integer; x:TMas; var r:TMas);
       procedure getRoots(f: TFunction; x: TMas; var r: TMas);
       procedure getExt(f: TFunction; x: TMas; var r: TMas);

implementation

procedure OutInStringGrid(var grid:TStringGrid;n:integer; Mas:TMas);
var
 i,rows:integer;
begin
  rows:=length(Mas);
  if grid.RowCount<rows+1 then grid.RowCount:=rows+1;
  for i:=0 to rows-1 do
  begin
    grid.Cells[n,i+1]:=Format('%.3f',[Mas[i]]);
  end;
  for i:=rows+1 to grid.RowCount-1 do
  begin
    grid.Cells[n,i]:='';
  end;
end;


function DebufOut (Mas:TMas):string;
var
 i:integer;
begin
           result:='';
          For i:=Low(Mas) to High(Mas) do
          begin
          result:=result+FloatToStr(Mas[i])+' ';
          end;

end;

procedure getX(a, b: real; n: integer; var r: TMas);
    var
      i:Integer;
      x,dx:Real;
    begin
              SetLength(r,n+1);
      x:=a;
      dx:=(b-a)/n;

                for i:=0 to n+1 do
                begin
                   r[i]:=x;
                   x:=x+dx;
                end;

    end;

 procedure GetY (f:TFunction; MasX:TMas; var MasY:TMas);
 var
  i:integer;
 begin
            SetLength(MasY,length(MasX));
            for i:=Low(MasY) to High(MasY) do
            begin
                   MasY[i]:=f(MasX[i]);
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


function getInt(x,y: TMas):real;
    var i: integer;
    begin
       result:=0;
       for i:=Low(x)+1 to high(x) do
          result:=result+(y[i]+y[i-1])*(x[i]-x[i-1])/2;
    end;

 procedure getFD(f: TFunction; x: TMas; var r: TMas);
   var i: integer;
   begin
      setlength(r,length(x));
      r[0]:=(f(x[1])-f(x[0]))/(x[1]-x[0]);
      for i:=1 to high(x)-1 do
         r[i]:=(f(x[i+1])-f(x[i-1]))/(x[i+1]-x[i-1]);
      r[i+1]:=(f(x[i+1])-f(x[i]))/(x[i+1]-x[i]);
   end;

 procedure d2F(f:TFunction;n:Integer; x:TMas; var r:TMas);
      var
        i:Integer;
      begin
         setlength(r,n);
         r[0]:=(f(x[2])-2*f(x[1])+f(x[0]))/sqrt(x[1]-x[0]);
         for i:=1 to n-2 do
         begin

          r[i]:=(f(x[i+1])-2*f(x[i])+f(x[i-1]))/sqr(x[i]-x[i-1]);

         end;
         r[n-1]:= (f(x[i+1])-2*f(x[i])+f(x[i-1]))/sqr(x[i+1]-x[i]);


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

end.

