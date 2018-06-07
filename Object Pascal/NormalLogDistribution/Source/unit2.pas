unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs;

type

  { TForm2 }

  TForm2 = class(TForm)
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

end.

