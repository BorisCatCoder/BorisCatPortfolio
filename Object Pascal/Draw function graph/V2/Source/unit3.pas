unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
type
  TPointXY = record
    x,y:real;

  end;
  TFunction = function (x:real):real;
  TMas = array of real;
  TPointMas = array of TPointXY;
  //plot test


  TPointXYArray = array of TPointXY;
  //plot test endline




  var
    FuncArray : array [0..4] of TFunction;
    FuncName : array [0..4] of string;

implementation
function f0(x:real):real;
begin
  result:=cos(x);

end;
function f1(x:real):real;
begin
  result:=ln(x);
end;

function f2(x:real):real;
begin
  result:=(-x*x+16);

end;

function f3(x:real):real;
begin
  result:=(x-3)*(x-1)*(x-2);
end;
function f4(x:real):real;
begin
  result:=(exp(-x*x/2)-1);
end;





begin
     FuncName[0]:='cos(x)';
     FuncName[1]:='ln(x)';
     FuncName[2]:='-x*x+16';
     FuncName[3]:='(x-3)*(x-1)*(x-2)*x';
     FuncName[4]:='exp(-x*x/2)-1';
      FuncArray[0]:=@f0;
      FuncArray[1]:=@f1;
      FuncArray[2]:=@f2;
      FuncArray[3]:=@f3;
      FuncArray[4]:=@f4;
end.
