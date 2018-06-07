unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Unit3, Unit2,
  ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    PaintBox1: TPaintBox;
    procedure FormShow(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1Resize(Sender: TObject);
     procedure ShowGraph(Sender:TObject);

  private
    { private declarations }
  public
     YMasG,XMasG,NullG,MinMaxG:TMas;
    f:TFunction;
    { public declarations }
  end;

var
  Form2: TForm2;

implementation
{$R *.lfm}
{ TForm2 }
function MaxReal(a,b:Real):Real;
 begin
  Result:=a;
  if a>b then Result:=a;
  if a<b then Result:=b;

 end;

  function MaxXY(Main:TMas):real;
 var
  //ymax,xmax:real;
   buf:real;
  i:integer;
 begin
  buf:=Main[0];
      for i:=Low(Main) to High(Main) do
      begin
          if Main[i]>buf then buf:=Main[i];
      end;
      result:=buf;
 end;

 function MinXY(Main:TMas):real;
 var
  //ymin,xmin:real;
  buf:real;
  i:integer;
 begin
      buf:=Main[0];
      for i:=Low(Main) to High(Main) do
      begin
          if Main[i]<buf then buf:=Main[i];
      end;
      result:=buf;
 end;
  function Max(a,b:integer):integer;
 begin
  Result:=b;
  if a>b then Result:=a;
  //if a<b then Result:=b;

 end;

    function Min(a,b:integer):integer;
 begin
  Result:=a;
  if a<b then Result:=b;
  //if a<b then Result:=b;

 end;

     function MinReal(a,b:Real):Real;
 begin
  Result:=a;
  //if a>b then Result:=a;
  if a>b then Result:=b;

 end;


 procedure TForm2.ShowGraph(Sender:TObject);
 var
    i:Integer;
  dxDraw,dyDraw,buf:Integer;
  AsixX,AsixY:Integer;
  x0,y0,x,y,n:Integer;
  my,mx,dimer:real;
  ky,kx:real; //тестовая компенсация y
  SumX,SumY:real;
  s:string;
  b:boolean;
  begin
   SetLength(NullG,0);
   SetLength(MinMaxG,0);
   getExt(f,XMasG,MinMaxG);
   getRoots(f,XMasG,NullG);
   if (length(XMasG)<>0) and (length(YMasG)<>0) then
   begin
         PaintBox1.Canvas.Pen.Color:=clBlack;

     SumY:=abs(MaxXY(YMasG)-MinXY(YMasG));
     SumX:=abs(MaxXY(XMasG)-MinXY(XMasG));
     //dxDraw:=round(abs(PaintBox1.Width/(2*(SumY))));
     //dyDraw:=round(abs(PaintBox1.Height/(2*SumX)));
     //ky:=MaxReal(Abs(MaxXY(YMasG)),abs(MinXY(YMasG)))/(PaintBox1.Height);
     //kx:=MaxReal(Abs(MaxXY(XMasG)),abs(MinXY(XMasG)))/(PaintBox1.Canvas.Width);
     dyDraw:=trunc(Self.PaintBox1.Height/(Abs(MaxXY(YMasG))+abs(MinXY(YMasG))));//Round(Self.PaintBox1.Height/(Length(YMasG)*(Abs(MaxXY(YMasG))+abs(MinXY(YMasG)) )));//Round(Self.PaintBox1.Height/(3*dimer));                    //Round(Self.PaintBox1.Height/(2*dimer));
      dxDraw:=trunc(Self.PaintBox1.Width/(Abs(MaxXY(XMasG))+abs(MinXY(XMasG))));
     AsixX:=round(abs(dxDraw*MinXY(XMasG)));
     AsixY:=round(abs(dyDraw*MaxXY(YMasG)));
     s:='';

     with Form2.PaintBox1 do
     begin
         Canvas.Line(AsixX,0,AsixX,Height);
         Canvas.Line(0,AsixY,Width,AsixY);
         x0:=AsixX+round(dxDraw*XMasG[0]);
         y0:=AsixY-round(dyDraw*YMasG[0]);
         s:=s+'x= ' +IntToStr(x0)+'y= '+IntToStr(y0)+' ';
         for i:=Low(XMasG)+1 to High(XMasG) do
          begin
          x:=AsixX+round(dxDraw*XMasG[i]);
          y:=AsixY-round(dyDraw*YMasG[i]);
          s:=s+'x= ' +IntToStr(x)+'y= '+IntToStr(y)+' ';
          Canvas.Line(x0,y0,x,y);
          x0:=x;
          y0:=y;
          //ShowMessage('DontIgnoreMe');
          end;

         if (length(NullG)<>0) then
         begin
         //    x0:=AsixX+round(dxDraw*NullG[0]);
         //y0:=AsixY-round(dyDraw*f(NullG[0]));
         //s:=s+'x= ' +IntToStr(x0)+'y= '+IntToStr(y0)+' ';
           Canvas.Pen.Color:=clRed;
         for i:=Low(NullG) to High(NullG) do
          begin
          x:=AsixX+round(dxDraw*NullG[i]);
          y:=AsixY-round(dyDraw*f(NullG[i]));
          Canvas.Rectangle(x-10,y-10,x+10,y+10);
          //s:=s+'x= ' +IntToStr(x)+'y= '+IntToStr(y)+' ';
          //Canvas.Line(x0,y0,x,y);
          //x0:=x;
          //y0:=y;
          //ShowMessage('DontIgnoreMe');
          end;
           end;
         if (length(MinMaxG)<>0) then
         begin
         Canvas.Pen.Color:=clGreen;
           for i:=Low(MinMaxG) to High(MinMaxG) do
          begin
          x:=AsixX+round(dxDraw*MinMaxG[i]);
          y:=AsixY-round(dyDraw*f(MinMaxG[i]));
          Canvas.Rectangle(x-10,y-10,x+10,y+10);
          //s:=s+'x= ' +IntToStr(x)+'y= '+IntToStr(y)+' ';
          //Canvas.Line(x0,y0,x,y);
          //x0:=x;
          //y0:=y;
          //ShowMessage('DontIgnoreMe');
          end;

         end;

           //ShowMessage(s);
     end;
      // Self.PaintBox1Resize(Sender);
   end;




  end;

procedure TForm2.PaintBox1Click(Sender: TObject);
begin

end;

procedure TForm2.FormShow(Sender: TObject);
begin
   Self.ShowGraph(Sender);
end;

procedure TForm2.PaintBox1Paint(Sender: TObject);
begin
  Self.ShowGraph(Sender);
end;

procedure TForm2.PaintBox1Resize(Sender: TObject);
begin
  Self.ShowGraph(Sender);
end;



end.

