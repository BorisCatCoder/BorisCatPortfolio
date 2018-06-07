unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ExtCtrls, StdCtrls ,MyMethod,MyFunc,Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckGroup1: TCheckGroup;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioGroup1: TRadioGroup;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  n:integer;
  a,b:real;

  Xmas,Ymas:TMas;
  ControlFunc : TFunction;


implementation

{$R *.lfm}

{ TForm1 }

function ValidData():boolean;
  begin
    result:=false;
      if  (Trim(Form1.Edit1.Text) <>'') and (Trim(Form1.Edit2.Text) <>'') and (Trim(Form1.Edit3.Text) <>'')  and  (Form1.ComboBox1.ItemIndex>=0) and (n>=0) then
      result:=true;
  end;



procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

function diff(x:real):real;
const dx=1e-6;
begin
  result:=(ControlFunc(x+dx*0.5)-ControlFunc(x-dx*0.5))/dx;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  DMas,D2Mas,IMas,Korni,gRot,DebufIntegrX,DebufIntegrY:TMas;
  Interg:real;
df:TFunction;
i:integer;
begin

  if ValidData then
  begin
   a:=StrToFloat(Trim(Edit1.Text));
   b:=StrToFloat(Trim(Edit2.Text));
   n:=StrToInt(Trim(Edit3.Text));
 // StringGrid1.RowCount:=StringGrid1.RowCount+10;
         //Невыполняется почему-то
     if n<=0 then ShowMessage('Кол-во интервалов должно быть больше нуля!');
     if ComboBox1.ItemIndex>=0 then ControlFunc:=FuncArray[ComboBox1.ItemIndex];
     GetX(a,b,n,XMas);

     OutInStringGrid(StringGrid1,0,XMas);
     // GetY(ControlFunc,Xmas,YMas);
     ////ShowMessage(DebufOut(YMas));
     //OutInStringGrid(Form1.StringGrid1,1,YMas);

     if CheckBox1.Checked then
     begin
       GetY(ControlFunc,Xmas,YMas);
       OutInStringGrid(Form1.StringGrid1,1,YMas);
     end;

     if CheckBox2.Checked then
     begin
      getFD(ControlFunc,XMas,DMas);
      OutInStringGrid(StringGrid1,2,DMas);
     end;

     if CheckBox3.Checked then
     begin
      d2F(ControlFunc,n,XMas,D2Mas);
      OutInStringGrid(Form1.StringGrid1,3,D2Mas);
     end;
      SetLength(DebufIntegrX,2);
      SetLength(DebufIntegrY,2);
     if CheckBox4.Checked then
     begin
        //Interg:=getInt(XMas,YMas);
        Interg:=0;
         Form1.StringGrid1.Cells[4,1]:=FloatToStr(Interg);
         Form1.StringGrid1.RowCount:=High(Xmas)+2;
        for i:=low(XMas)+1 to High(XMas) do
        begin
          DebufIntegrX[0]:=XMas[i];
          DebufIntegrX[1]:=XMas[i+1];
          DebufIntegrY[0]:=YMas[i];
          DebufIntegrY[1]:=YMas[i+1];

           Interg:=getInt(DebufIntegrX,DebufIntegrY);
          //Interg:=getInt([XMas[i]],[YMas[i]]);
          //ShowMessage(FloatToStr(Interg));
          Form1.StringGrid1.Cells[4,i+1]:=FloatToStr(Interg)+Form1.StringGrid1.Cells[4,i];
        end;
          Interg:=getInt(XMas,YMas);
          Form1.StringGrid1.RowCount:=Form1.StringGrid1.RowCount+1;
        StringGrid1.Cells[4,Form1.StringGrid1.RowCount-1]:=FloatToStr(Interg);
     end;


     if   RadioButton2.Checked then
     begin
     getRoots(ControlFunc,XMas,Korni);

     OutInStringGrid(Form1.StringGrid1,5,Korni);
     end;

     if RadioButton3.Checked then
     begin
           getExt(ControlFunc,XMas,gRot);
       //getRoots(@diff,XMas,gRot);
       OutInStringGrid(Form1.StringGrid1,6,gRot);
     end;



  end
  else
          begin
              ShowMessage('Не все данные введены');
          end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var form:TForm2;
begin
 // Form2.Show;
 // if length(Xmas)=0 then
  Button1Click(sender);
  form:=TForm2.Create(self);
  form.Show();
  form.setData(Xmas,YMas);
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  If (Length(Xmas)>0) and ValidData then begin
  GetY(ControlFunc,Xmas,YMas);
  OutInStringGrid(Form1.StringGrid1,1,YMas);

  end;
end;

procedure TForm1.CheckBox2Change(Sender: TObject);
var
  DMas:TMas;
begin
  if ValidData  and  (Length(XMas)>0) then
  begin
  SetLength(DMas,length(XMas));
  //GetY(ControlFunc,XMas,YMas);
  getFD(ControlFunc,XMas,DMas);
   OutInStringGrid(StringGrid1,2,DMas);
  end;
end;

procedure TForm1.CheckBox3Change(Sender: TObject);
var
  D2Mas:TMas;
begin
  if ValidData and (Length(XMas)>0) then
  begin
   d2F(ControlFunc,n,XMas,D2Mas);
    OutInStringGrid(Form1.StringGrid1,3,D2Mas);
  end;
end;

procedure TForm1.CheckBox4Change(Sender: TObject);
var
  Interg:real;
begin
  if ValidData and (Length(YMas)>0) and (Length(XMas)>0) then
  begin
  Interg:=getInt(XMas,YMas);
  Form1.StringGrid1.Cells[4,1]:=FloatToStr(Interg);
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 // If ComboBox1.ItemIndex>=0 then ControlFunc:=FuncArray[ComboBox1.ItemIndex];
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
  with StringGrid1 do
begin
  ColCount:=7;
  Cells[0,0]:='x';
  Cells[1,0]:='f(x)';
  Cells[2,0]:='f''(x)';
  Cells[3,0]:='f''''(x)';
  Cells[4,0]:='Интеграл';
  Cells[5,0]:='Корни';
  Cells[6,0]:='Экстремумы';
end;

end;

procedure TForm1.RadioButton2Change(Sender: TObject);
var
  Korni:TMas;
begin

  //if ValidData  and (Length(XMas)>0) then
  //   begin
  //
       //getRoots(ControlFunc,XMas,Korni);
       //
       //OutInStringGrid(Form1.StringGrid1,5,Korni);
  //   end;
end;

procedure TForm1.RadioButton3Change(Sender: TObject);
Var
  Ext:TMas;
begin
           if ValidData and (Length(XMas)>0) then
           begin
             getExt(ControlFunc,Xmas,Ext);
               OutInStringGrid(Form1.StringGrid1,6,Ext);
           end;
end;

end.

