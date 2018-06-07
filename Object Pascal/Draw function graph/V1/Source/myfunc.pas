unit MyFunc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
type
  TFunction = function (x:real):real;
  TMas = array of real;
  var
    FuncArray : array [0..4] of TFunction;
    FuncName : array [0..4] of string;

implementation
       function f0 (x:real):real;
       begin
         result:=x-1;
       end;

       function f1 (x:real):real;
       begin
         result:=(x-1)*(x+3);
       end;

       function f2 (x:real):real;
       begin
         result:= sin(x);
       end;

       function f3 (x:real):real;
       begin
         result:=x*(x-1)*(x-4);
       end;

       function f4(x:real):real;
       begin
         result:=sin(x)*x;
       end;

  begin
      FuncName[0]:='x-1';
      FuncName[1]:='(x-1)*(x+3)';
      FuncName[2]:='sin(x)';
      FuncName[3]:='x*(x-1)*(x-4)';
      FuncName[4]:='sin(x)*x';
      FuncArray[0]:=@f0;
      FuncArray[1]:=@f1;
      FuncArray[2]:=@f2;
      FuncArray[3]:=@f3;
      FuncArray[4]:=@f4;
end.

