unit MainFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Generics.Collections, GameItems, Vcl.StdCtrls, ItemsLoader;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox27: TCheckBox;
    CheckBox28: TCheckBox;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    FLoader: TItemsLoader;
    function GetSelectedRunes: TArray<string>;
  public
    { Public declarations }
    property SelectedRunes: TArray<string> read GetSelectedRunes;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CheckBox1Click(Sender: TObject);
var
  FilteredItems: TArray<TGameItem>;
  Descriptions: TStringList;
begin
  Descriptions := TStringList.Create;
  try
    FilteredItems := FLoader.FilterItems(SelectedRunes);
    for var Item in FilteredItems do
    begin
      Descriptions.Add(Item.Description);
    end;
    Memo1.Text := Descriptions.Text;
  finally
    Descriptions.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FLoader := TItemsLoader.Create;
  FLoader.LoadFromFile('rune.txt');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FLoader.Free;
end;

function TForm1.GetSelectedRunes: TArray<string>;
var
  SelectedRunes: TStringList;
  I: Integer;
begin
  SelectedRunes := TStringList.Create;
  try
    for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TCheckBox) and (TCheckBox(Components[i]).Checked) then
      begin
        SelectedRunes.Add(TCheckBox(Components[i]).Caption);
      end;
    end;
    Result := SelectedRunes.ToStringArray;
  finally
    SelectedRunes.Free;
  end;
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
