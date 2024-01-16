unit MainFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Generics.Collections, GameItems, Vcl.StdCtrls, ItemsLoader,
  Vcl.ExtCtrls, Vcl.Imaging.GIFImg, StrUtils;

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
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    Image18: TImage;
    Image19: TImage;
    Image20: TImage;
    Image21: TImage;
    Image22: TImage;
    Image23: TImage;
    Image24: TImage;
    Image25: TImage;
    Image26: TImage;
    Image27: TImage;
    Image28: TImage;
    Image29: TImage;
    Image30: TImage;
    Image31: TImage;
    Image32: TImage;
    Image33: TImage;
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FLoader: TItemsLoader;
    function GetSelectedRunes: TArray<string>;
  public
    { Public declarations }
    procedure RefillItems;
    property SelectedRunes: TArray<string> read GetSelectedRunes;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  RefillItems;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  RefillItems;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FLoader := TItemsLoader.Create;
  FLoader.LoadFromFile('rune.txt');

  Image1.Picture.LoadFromFile('images\El.gif');
  Image2.Picture.LoadFromFile('images\Eld.gif');
  Image3.Picture.LoadFromFile('images\Tir.gif');
  Image4.Picture.LoadFromFile('images\Nef.gif');
  Image5.Picture.LoadFromFile('images\Eth.gif');
  Image6.Picture.LoadFromFile('images\Ith.gif');
  Image7.Picture.LoadFromFile('images\Tal.gif');
  Image8.Picture.LoadFromFile('images\Ral.gif');
  Image9.Picture.LoadFromFile('images\Ort.gif');
  Image10.Picture.LoadFromFile('images\Thul.gif');
  Image11.Picture.LoadFromFile('images\Amn.gif');
  Image12.Picture.LoadFromFile('images\Sol.gif');
  Image13.Picture.LoadFromFile('images\Shael.gif');
  Image14.Picture.LoadFromFile('images\Dol.gif');
  Image15.Picture.LoadFromFile('images\Hel.gif');
  Image16.Picture.LoadFromFile('images\Io.gif');
  Image17.Picture.LoadFromFile('images\Lum.gif');
  Image18.Picture.LoadFromFile('images\Ko.gif');
  Image19.Picture.LoadFromFile('images\Fal.gif');
  Image20.Picture.LoadFromFile('images\Lem.gif');
  Image21.Picture.LoadFromFile('images\Pul.gif');
  Image22.Picture.LoadFromFile('images\Um.gif');
  Image23.Picture.LoadFromFile('images\Mal.gif');
  Image24.Picture.LoadFromFile('images\Ist.gif');
  Image25.Picture.LoadFromFile('images\Gul.gif');
  Image26.Picture.LoadFromFile('images\Vex.gif');
  Image27.Picture.LoadFromFile('images\Ohm.gif');
  Image28.Picture.LoadFromFile('images\Lo.gif');
  Image29.Picture.LoadFromFile('images\Sur.gif');
  Image30.Picture.LoadFromFile('images\Ber.gif');
  Image31.Picture.LoadFromFile('images\Jah.gif');
  Image32.Picture.LoadFromFile('images\Cham.gif');
  Image33.Picture.LoadFromFile('images\Zod.gif');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FLoader.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  RefillItems;
end;

function TForm1.GetSelectedRunes: TArray<string>;
var
  SelectedRunes: TStringList;
  I: Integer;
begin
  SelectedRunes := TStringList.Create;
  try
    for I := 0 to ComponentCount - 1 do
    begin
      if (Components[I] is TCheckBox) and (TCheckBox(Components[I]).Checked) then
      begin
        SelectedRunes.Add(TCheckBox(Components[I]).Caption);
      end;
    end;
    Result := SelectedRunes.ToStringArray;
  finally
    SelectedRunes.Free;
  end;
end;

procedure TForm1.RefillItems;
var
  AnyRunesSelected: Boolean;
  FilterTextNotEmpty: Boolean;
  FilteredItems: TArray<TGameItem>;
  Descriptions: TStringList;
begin
  AnyRunesSelected := Length(SelectedRunes) > 0;
  FilterTextNotEmpty := Length(ComboBox1.Text) > 0;

  FilteredItems := FLoader.Filter(
    function(Item: TGameItem): Boolean
    begin
      Result := True;

      if AnyRunesSelected and FilterTextNotEmpty then
      begin
        Result := Item.HasAllRequiredRunes(SelectedRunes) and
          ContainsText(Item.Description, ComboBox1.Text);
      end
      else if AnyRunesSelected then
        Result := Item.HasAllRequiredRunes(SelectedRunes)
      else if FilterTextNotEmpty then
        Result := ContainsText(Item.Description, ComboBox1.Text);
    end);

  Descriptions := TStringList.Create;
  try
    for var Item in FilteredItems do
    begin
      Descriptions.Add(Item.Description);
    end;
    Memo1.Text := Descriptions.Text;
  finally
    Descriptions.Free;
  end;
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
