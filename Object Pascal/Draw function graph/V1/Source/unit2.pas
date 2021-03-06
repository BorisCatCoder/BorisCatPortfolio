unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, Graphics, Dialogs,
  ExtCtrls;

type

  { TPlot }
  TPlotPoint=record x,y:real; end;
  TPlotPoints=array of TPlotPoint;
  TPlot=class
     canvas:TCanvas;
     rect,view_rect:TRect;
     xo,x1,x2,sx1,sx2:real; xaxis:string;
     yo,y1,y2,sy1,sy2:real; yaxis:string;
     grid_color,axis_color,background,color:TColor;
     x,y:real; nfirst:boolean;
     arrow_len, arrow_angle:double;
     axis_w1:integer;

     plots:array of TPlotPoints;

     procedure SetDefault;
     procedure Draw;
     procedure setRect(r:TRect);

     procedure clear;
     procedure addPoints(points:TPlotPoints);

     procedure drawBackground;
     procedure drawGrid;
     procedure drawAxis;
     procedure drawAxisNumbers;
     procedure drawAxisNames;
     procedure drawLines;
     procedure draw_shape(c:TCanvas;xOs,yOs:integer);
     procedure startLine;
     procedure lineTo(xx,yy:real);
     procedure x2v(xx,yy:real;var rx,ry:real);
     procedure x2vi(xx,yy:real;var rx,ry:integer);
     procedure drawArrow(ax,ay,bx,by:real);

     procedure podgon(xx1,xx2,yy1,yy2:real);
  end;

  { TForm2 }

  TForm2 = class(TForm)
    PaintBox1: TPaintBox;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
  private
    plot:TPlot;
    { private declarations }
  public
    { public declarations }
    procedure setData(const x,y:array of real);

  end;



var
  Form2: TForm2;
  dx,dy,x0,y0:integer;
implementation
uses math;

{$R *.lfm}

{ TForm2 }
  {
function ColX(MasX:TMas;usp:String):integer;
var
  i,k:integer;
begin        k:=0;
            if usp='+' then
            begin

            for i:=Low(MasX) to High(MasX) do
            begin
                if MasX[i]>=0 then k:=k+1;
            end;

            end
            else
            begin
               for i:=Low(MasX) to High(MasX) do
               begin
                   if MasX[i]<0 then k:=k+1;
               end;

            end;
         result:=k;
end;
function Max(a,b:real):real;
begin
         if a>=b then result:=a
         else result:=b;
end;

procedure Draw(MasX,MasY:Tmas);
var
  i:integer;
begin
       //x0:=Form2.PaintBox1.ClientWidth/2;
       //y0:=Form2.PaintBox1.ClientHeight/2;
       dx:=trunc(x0/(Max(ColX(MasX,'+'),ColX(MasX,'-'))+1));
       dy:=trunc(y0/(Max(ColX(MasY,'+'),ColX(MasY,'-'))+1));
       //Form2.PaintBox1.Canvas.Line(0,0,0,y0);
end;
  }
{ TPlot }

 procedure TPlot.draw_shape(c:TCanvas; xOs,yOs:integer);
 begin

 end;

procedure TPlot.SetDefault;
begin
     rect.Left:=0;
     rect.Right:=640;
     rect.Top:=0;
     rect.Bottom:=480;
     view_rect:=rect;
     xo:=0;x1:=-1;x2:=1; sx1:=0.2; sx2:=0.1; xaxis:='X';
     yo:=0;y1:=-1;y2:=1; sy1:=0.2; sy2:=0.1; yaxis:='Y';
     grid_color:=RGBToColor(0,$90,0);
     axis_color:=RGBToColor($B0,$B0,$B0);
     background:=RGBToColor(0,0,0);
     color:=RGBToColor(255,255,255);
     arrow_len:=10;
     arrow_angle:=Pi/180*10;
     axis_w1:=4;
end;

procedure TPlot.Draw;
begin
  drawBackground;
  drawAxisNumbers;
  drawGrid;
  drawAxis;
  drawAxisNames;
  drawLines;
end;

procedure TPlot.setRect(r: TRect);
var margin:integer;
begin
  margin:=20;
  rect:=r;
  view_rect:=r;
  inc(rect.Left,margin);
  dec(rect.Right,margin);
  inc(rect.Top,margin);
  dec(rect.Bottom,margin);
end;

procedure TPlot.clear;
begin
  setlength(plots,0);
end;

procedure TPlot.addPoints(points: TPlotPoints);
var n:integer;
begin
  n:=length(plots);
  setlength(plots,n+1);
  plots[n]:=points;
end;

procedure TPlot.drawBackground;
begin
  canvas.Brush.Color:=background;
  canvas.FillRect(view_rect);
end;

procedure TPlot.drawGrid;
var xx,yy,xxpoint,yypoint:real; px1,px2,py1,py2:integer;
  TreoBeginUp,TreoBeginDown,TreoEnd:TPoint;
  Treo:array of TPoint;
begin
  Canvas.Pen.Color:=grid_color;
  Canvas.Pen.Style:=TPenStyle.psDash;
  xx:=xo;

   xxpoint:=xo;
   yypoint:=yo;
   Canvas.Pen.Color:=clRed;
   Canvas.Brush.Color:=clRed;
   while xxpoint<=x1 do
   begin
     while yypoint<=y1 do
begin
 //Canvas.Ellipse(StrToInt(IntToStr(round(xxpoint))),StrToInt(IntToStr(round(yypoint))),100,100);
  drawArrow(xxpoint,yypoint,xxpoint+5,yypoint+5);

  //TreoBeginUp.x:=StrToInt(IntToStr(round(xxpoint)));
        //TreoBeginUp.y:=StrToInt(IntToStr(round(yypoint)))-StrToInt(IntToStr(round(sy1)));
        //   TreoBeginDown.x:=StrToInt(IntToStr(round(xxpoint)));
        //TreoBeginDown.y:=StrToInt(IntToStr(round(yypoint)))+StrToInt(IntToStr(round(sy1)));
        //TreoEnd.x:=StrToInt(IntToStr(round(xxpoint)))+StrToInt(IntToStr(round(sx1)));
        //TreoEnd.y:=StrToInt(IntToStr(round(yypoint)))+StrToInt(IntToStr(round(sy1)));
        //SetLength(Treo,3);
        //Treo[0]:=TreoBeginUp;
        //Treo[1]:=TreoBeginDown;
        //Treo[2]:=TreoEnd;
        //Canvas.Polyline(Treo);
        //yypoint:=yypoint+sy1;
end;

   end;






  Canvas.Pen.Color:=grid_color;

   //Canvas.Brush.Color:=clBlack;
  while xx>=x1 do
  begin
    x2vi(xx,y1,px1,py1);
    x2vi(xx,y2,px2,py2);
    Canvas.Line(px1,py1,px2,py2);
    //Canvas.Ellipse(px2,py2-5,px2+5,py2+5);
    xx:=xx-sx1;

  end;
  xx:=xo+sx1;
  while xx<=x2 do
  begin
    x2vi(xx,y1,px1,py1);
    x2vi(xx,y2,px2,py2);
    Canvas.Line(px1,py1,px2,py2);
    //Canvas.Ellipse(px2,py2-5,px2+5,py2+5);
    xx:=xx+sx1;

  end;

  yy:=y0;
  while yy>=y1 do
  begin
    x2vi(x1,yy,px1,py1);
    x2vi(x2,yy,px2,py2);
    Canvas.Line(px1,py1,px2,py2);
    //Canvas.Ellipse(px2,py2-5,px2+5,py2+5);
    yy:=yy-sy1;
  end;
  yy:=y0+sy1;
  while yy<=y2 do
  begin
    x2vi(x1,yy,px1,py1);
    x2vi(x2,yy,px2,py2);
    Canvas.Line(px1,py1,px2,py2);
    //Canvas.Ellipse(px2,py2-5,px2+5,py2+5);
    yy:=yy+sy1;
  end;


  Canvas.Pen.Style:=TPenStyle.psSolid;
end;

procedure TPlot.drawAxis;
begin
  Canvas.Brush.Color:=clBlack;
  Canvas.Pen.Color:=axis_color;
  drawArrow(x1,yo,x2,y0);
  drawArrow(xo,y1,xo,y2);
end;

procedure TPlot.drawAxisNumbers;
var px1,py1,px2,py2,px3,py3,hh:integer;
  txt:string;
  xx,yy:real;
  w,h:integer;
  function fmt(a:real):string;
  begin
    result:=Format('%.2f',[a]);
  end;

begin
  Canvas.Pen.Color:=axis_color;
  Canvas.Font.Color:=axis_color;
  Canvas.Font.Name:='Verdana';
  Canvas.Font.Size:=8;
  hh:=axis_w1;
  xx:=xo;
  while xx>=x1 do xx:=xx-sx1;
  xx:=xx+sx1;
  while xx<=x2 do
  begin
    x2vi(xx,yo,px1,py1);
    Canvas.Line(px1,py1-hh,px1,py1+hh);
    txt:=fmt(xx);
    w:=Canvas.GetTextWidth(txt);
    h:=Canvas.GetTextHeight(txt);
    Canvas.TextOut(px1-w div 2,py1-hh-h-2,txt);
    xx:=xx+sx1;
  end;

  yy:=yo;
  while yy>=y1 do yy:=yy-sy1;
  yy:=yy+sy1;
  while yy<=y2 do
  begin
    x2vi(xo,yy,px1,py1);
    Canvas.Line(px1-hh,py1,px1+hh,py1);
    txt:=fmt(yy);
    w:=Canvas.GetTextWidth(txt);
    h:=Canvas.GetTextHeight(txt);
    Canvas.TextOut(px1+hh+2,py1-h div 2-2,txt);
    yy:=yy+sy1;
  end;
end;

procedure TPlot.drawAxisNames;
var p1x,p1y,p2x,p2y:integer; txt:string; w,h:integer;
begin
  Canvas.Font.Color:=axis_color;
  Canvas.Font.Name:='Verdana';
  Canvas.Font.Size:=10;

  x2vi(x2,y0,p1x,p1y);
  txt:=xaxis;
  w:=Canvas.GetTextWidth(txt);
  h:=Canvas.GetTextHeight(txt);
  p2x:=round(p1x-w-arrow_len);
  p2y:=round(p1y+axis_w1+2);
  Canvas.TextOut(p2x,p2y,txt);

  x2vi(x0,y2,p1x,p1y);
  txt:=yaxis;
  w:=Canvas.GetTextWidth(txt);
  h:=Canvas.GetTextHeight(txt);
  p2x:=round(p1x-w-axis_w1-2);
  p2y:=round(p1y+arrow_len-h div 2+2);
  Canvas.TextOut(p2x,p2y,txt);
end;

procedure TPlot.startLine;
begin
  nfirst:=true;
  canvas.Pen.Color:=color;
end;

procedure TPlot.lineTo(xx, yy: real);
var px1,px2,py1,py2:integer;
begin
  if nfirst then nfirst:=false else
  begin
    x2vi(x,y,px1,py1);
    x2vi(xx,yy,px2,py2);
    canvas.Line(px1,py1,px2,py2);
  end;
  x:=xx;
  y:=yy;
end;

procedure TPlot.x2v(xx, yy: real; var rx, ry: real);
begin
  rx:=rect.Left + (rect.Right-rect.Left)*(xx-x1)/(x2-x1);
  ry:=rect.Bottom - (rect.Bottom-rect.Top)*(yy-y1)/(y2-y1);
end;

procedure TPlot.x2vi(xx, yy: real; var rx, ry: integer);
begin
  rx:=round(rect.Left + (rect.Right-rect.Left)*(xx-x1)/(x2-x1));
  ry:=round(rect.Top + (rect.Bottom-rect.Top)*(yy-y2)/(y1-y2));
end;

procedure TPlot.drawArrow(ax, ay, bx, by: real);
var s,c,nx,ny,mx,my,len:real;
  p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y:real;
begin
  s:=sin(arrow_angle);
  c:=cos(arrow_angle);
  x2v(ax,ay,p1x,p1y);
  x2v(bx,by,p2x,p2y);

  nx:=p2x-p1x;
  ny:=p2y-p1y;
  len:=sqrt(nx*nx+ny*ny);
  nx:=nx/len;
  ny:=ny/len;
  mx:= -ny;
  my:=nx;

  p3x:=p2x-arrow_len*( nx*c+s*mx);
  p3y:=p2y-arrow_len*( ny*c+s*my);

  p4x:=p2x-arrow_len*( nx*c-s*mx);
  p4y:=p2y-arrow_len*( ny*c-s*my);

  Canvas.Line(round(p1x),round(p1y),round(p2x),round(p2y));
  Canvas.Line(round(p2x),round(p2y),round(p3x),round(p3y));
  Canvas.Line(round(p2x),round(p2y),round(p4x),round(p4y));
end;

procedure TPlot.podgon(xx1, xx2, yy1, yy2: real);
var dx,dy,px,py, sdx,sdy,nx,ny:real;
begin
  dx:=xx2-xx1;
  dy:=yy2-yy1;
  px:=ceil( ln(dx)/ln(10) ) - 2;
  py:=ceil( ln(dy)/ln(10) ) - 2;
  sdx:=power(10,px);
  sdy:=power(10,py);

  nx:=dx/sdx;
  if nx>50 then sdx:=sdx*5 else
  if nx>25 then sdx:=sdx*2.5;
  ny:=dy/sdy;
  if ny>50 then sdy:=sdy*5 else
  if ny>25 then sdy:=sdy*2.5;

  x1:=floor(xx1/sdx)*sdx;
  x2:=ceil(xx2/sdx)*sdx;
  if (xo<x1) then xo:=x1;
  if (xo>x2) then xo:=x2;

  y1:=floor(yy1/sdy)*sdy;
  y2:=ceil(yy2/sdy)*sdy;
  if (yo<y1) then yo:=y1;
  if (yo>y2) then yo:=y2;

  sx1:=sdx;
  sx2:=sdx*0.1;
  sy1:=sdy;
  sy2:=sdy*0.1;
end;

procedure TPlot.drawLines;
 var xx,dx,yy:real;
   i,n,j,m:integer;
begin
  n:=length(plots);
  for i:=0 to n-1 do
  begin
    startLine;
    m:=length(plots[i]);
    for j:=0 to m-1 do lineTo(plots[i][j].x,plots[i][j].y);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  plot:=TPlot.Create;
  plot.SetDefault;
end;

procedure TForm2.PaintBox1Click(Sender: TObject);
begin

end;

procedure TForm2.PaintBox1Paint(Sender: TObject);
begin
  plot.Canvas:=PaintBox1.Canvas;
  plot.SetRect(PaintBox1.BoundsRect);
  plot.draw();
end;

procedure TForm2.setData(const x, y: array of real);
var i,n:integer; p:TPlotPoints;
  xmin,xmax,ymin,ymax:real;
begin
  plot.clear;
  n:=length(x); if length(y)<n then n:=length(y);
  if n<1 then exit;
  setlength(p,n);
  xmin:=x[0];xmax:=xmin;
  ymin:=y[0];ymax:=ymax;
  for i:=0 to n-1 do
  begin
    p[i].x:=x[i];
    p[i].y:=y[i];
    if xmin>x[i] then xmin:=x[i];
    if xmax<x[i] then xmax:=x[i];
    if ymin>y[i] then ymin:=y[i];
    if ymax<y[i] then ymax:=y[i];
  end;
  plot.addPoints(p);
  plot.podgon(xmin,xmax,ymin,ymax);
end;


end.

