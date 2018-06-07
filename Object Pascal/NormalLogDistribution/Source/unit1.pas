unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls,Unit2,Math;

type

  { TForm1 }
  TXYRecord = record
    x,f:real;
  end;
  TXYRealMatr = array of TXYRecord;

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  XYRealMatr: TXYRealMatr;

implementation

{$R *.lfm}

{ TForm1 }
function ValidData:boolean;
begin
  if (Form1.Edit1.Text<>'')and(Form1.Edit2.Text<>'')and(Form1.Edit3.Text<>'')and(Form1.Edit4.Text<>'')and(Form1.Edit5.Text<>'') then
  Result:=true
  else
    Result:=false;
end;
procedure EnterData(var a,b,lam,g:real;var n:integer);
begin
   n:=StrToInt(Form1.Edit3.Text);
   a:=StrToFloat(Form1.Edit1.Text);
   b:=StrToFloat(Form1.Edit2.Text);
   lam:=StrToFloat(Form1.Edit4.Text);
   g:=StrToFloat(Form1.Edit5.Text);
  end;


  function Yi(r,lambda:Real):Real;
  begin

    result:=((-1)*ln(r))/lambda;

  end;

  function Xi(yi,b,c:Real):real;
  begin
    Result:=Exp(c*yi+b);
  end;

  function f_x (x,c,b:Real):real;
  var
    explevel,gain:Real;

  begin

    gain:=1/(c*x*sqrt(2*Pi));
    explevel:=((-1)*Power((Ln(x)-b),2.0))/(2*Power(c,c));
    Result:=gain*explevel;
  end;

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.Panel1Click(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);

const
    c=2;
var
  min,max,x,y,r,lambda,b:Real;
    i,n:Integer;
begin
   if ValidData then
   begin
    EnterData(min,max,lambda,b,n);
    SetLength(XYRealMatr,n);
    Randomize;
     for i:=Low(XYRealMatr) to High(XYRealMatr) do
     begin
       r:=Random*abs(min-max)+min;
       y:=Yi(r,lambda);
       x:=Xi(y,b,c);
       XYRealMatr[i].x:=x;
       XYRealMatr[i].f:=f_x(x,c,b);
       Form1.Memo1.Lines.AddStrings(FloatToStr(x)+'    '+FloatToStr(XYRealMatr[i].f));
       Form2.Chart1LineSeries1.AddXY(XYRealMatr[i].x,XYRealMatr[i].f);
     end;
      Form2.Chart1.Show;
      Form2.Show;

   end
   else
   begin
     ShowMessage('Неверно введенные данные');
   end;
end;

end.

