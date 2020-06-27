object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 107
  ClientWidth = 280
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 159
    Top = 8
    Width = 41
    Height = 33
    OnMouseUp = ControlClick
  end
  object Panel1: TPanel
    Left = 24
    Top = 32
    Width = 176
    Height = 25
    BevelOuter = bvSpace
    Color = clWhite
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 0
    Visible = False
    OnMouseUp = ControlClick
  end
  object MediaPlayer1: TMediaPlayer
    Left = 191
    Top = 51
    Width = 57
    Height = 30
    VisibleButtons = [btPlay, btStop]
    DoubleBuffered = True
    Display = Panel2
    FileName = 'D:\_test\INTRO.AVI'
    Visible = False
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 24
    Top = 63
    Width = 137
    Height = 18
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    Visible = False
  end
  object StartupTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = StartupTimerTimer
    Left = 216
    Top = 16
  end
end
