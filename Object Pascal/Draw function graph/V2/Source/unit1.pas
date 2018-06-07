unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls,Unit2,Unit3,Unit4;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckGroup1: TCheckGroup;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioGroup2: TRadioGroup;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  a,b:real;
  n:integer;
  Xmas,YMas,dfMas,d2fMas,RootMas,MinMaxMas,IntegralMas:TMas;
  f:TFunction;

implementation

{$R *.lfm}

{ TForm1 }



procedure DebufOut(r:TMas);
var
  i:integer;
  s:string;
begin
  s:='';
  for i:=Low(r) to High(r) do
  begin
    //ShowMessage();
  s:=s+' '+FloatToStr(r[i]);
  end;
  ShowMessage(s);

end;

procedure GridIntro(var Grid:TStringGrid);
begin
  Grid.ColCount:=1;
  Grid.RowCount:=1;
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  if  (Trim(Form1.Edit3.Text)<>'') and (Trim(Form1.Edit1.Text)<>'')  and (Trim(Form1.Edit2.Text)<>'') then
  begin
  a:=StrToFloat(Trim(Form1.Edit3.Text));
  b:=StrToFloat(Trim(Form1.Edit1.Text));
  n:=StrToInt(Trim(Form1.Edit2.Text));
  InitX(Xmas,a,b,n);
  //DebufOut(Xmas);
  f:=FuncArray[Form1.ComboBox1.ItemIndex];
  GridIntro(Self.StringGrid1);
  InitF(YMas,f,Xmas);
  OutInGrid(Form1.StringGrid1,Xmas,0);
  //DebufOut(Xmas);
 // ShowMessage(FloatToStr(a)+' '+FloatToStr(b)+' '+ IntToStr(n));

      case Form1.RadioGroup2.ItemIndex of
      //0: begin  //Self.StringGrid1.ColCount:=Self.StringGrid1.ColCount+1; Self.StringGrid1.Cells[Self.StringGrid1.ColCount-1,0]:='f(x)'; OutInGrid(Form1.StringGrid1,Ymas,1);
       // Self.CheckGroup1.Visible:=true;  end;  //OutInGrid(Self.StringGrid1,Ymas,1);
      1: begin Self.StringGrid1.ColCount:=Self.StringGrid1.ColCount+1; Self.StringGrid1.Cells[Self.StringGrid1.ColCount-1,0]:='Корни'; getRoots(f,Xmas,RootMas); if (length(RootMas)<>0) then OutInGrid(Form1.StringGrid1,RootMas,Self.StringGrid1.ColCount-1);  end;
      2: begin Self.StringGrid1.ColCount:=Self.StringGrid1.ColCount+1; Self.StringGrid1.Cells[Self.StringGrid1.ColCount-1,0]:='Экстремумы'; getExt(f,Xmas,MinMaxMas); if (length(MinMaxMas)<>0) then OutInGrid(Form1.StringGrid1,MinMaxMas,Self.StringGrid1.ColCount-1);  end;

      end;
       if Form1.CheckGroup1.Checked[0] then  begin Self.StringGrid1.ColCount:=Self.StringGrid1.ColCount+1; Self.StringGrid1.Cells[Self.StringGrid1.ColCount-1,0]:='f(x)'; InitF(YMas,f,Xmas); OutInGrid(Form1.StringGrid1,Ymas,Self.StringGrid1.ColCount-1);  end;
       if Form1.CheckGroup1.Checked[1] then begin Self.StringGrid1.ColCount:=Self.StringGrid1.ColCount+1; Self.StringGrid1.Cells[Self.StringGrid1.ColCount-1,0]:='df(x)'; df(XMas,dfMas,f); OutInGrid(Form1.StringGrid1,dfMas,Self.StringGrid1.ColCount-1); end;
       if Form1.CheckGroup1.Checked[2] then begin Self.StringGrid1.ColCount:=Self.StringGrid1.ColCount+1; Self.StringGrid1.Cells[Self.StringGrid1.ColCount-1,0]:='d2f(x)'; d2f(Xmas,d2fMas,f); OutInGrid(Form1.StringGrid1,d2fMas,Self.StringGrid1.ColCount-1); end;
       if Form1.CheckGroup1.Checked[3] then begin Self.StringGrid1.ColCount:=Self.StringGrid1.ColCount+1; Self.StringGrid1.Cells[Self.StringGrid1.ColCount-1,0]:='Интеграл'; Integral(f,Xmas,IntegralMas); OutInGrid(Form1.StringGrid1,IntegralMas,Self.StringGrid1.ColCount-1); end;


  end
  else ShowMessage('Данные введены не правильно');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   Form1.Button1Click(Sender);
   if Form2.Visible then Form2.Visible:=not Form2.Visible;
  Form2.XMasG:=XMas;
  Form2.YMasG:=YMas;
  Form2.f:=f;
  Form2.Show;
  //Form2.ShowGraph;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
begin
  For i:= Low(FuncName) to High(FuncName) do
  begin
    ComboBox1.Items.Add(FuncName[i]);
  end;
  ComboBox1.ItemIndex:=ComboBox1.Items.Count-1;
//  with StringGrid1 do
//begin
//  ColCount:=7;
//  Cells[0,0]:='x';
//  Cells[1,0]:='f(x)';
//  Cells[2,0]:='f''(x)';
//  Cells[3,0]:='f''''(x)';
//  Cells[4,0]:='Интеграл';
//  Cells[5,0]:='Корни';
//  Cells[6,0]:='Экстремумы';
//end;
  Self.CheckGroup1.Visible:=false;
end;

procedure TForm1.RadioGroup2Click(Sender: TObject);
begin
   if Self.RadioGroup2.ItemIndex=0 then
  Self.CheckGroup1.Visible:=true; //not Self.CheckGroup1.Visible;
end;

end.

