unit GameItems;

interface

uses
  System.SysUtils, System.Classes;

type
  TGameItem = class
  private
    FDescription: TStringList;
    function GetDescription: string;
  public
    constructor Create(const ADescription: string);
    destructor Destroy; override;
    function ExtractRunes: TArray<string>;
    function HasAllRequiredRunes(const RequiredRunes: TArray<string>): Boolean;
    property Description: string read GetDescription;
  end;

implementation

uses
  System.Generics.Collections;

{ TItem }

constructor TGameItem.Create(const ADescription: string);
begin
  FDescription := TStringList.Create;
  FDescription.Text := ADescription;
end;

destructor TGameItem.Destroy;
begin
  FDescription.Free;
  inherited;
end;

function TGameItem.ExtractRunes: TArray<string>;
var
  RuneString: string;
  Runes: TStringList;
begin
  Result := nil;

  if (FDescription.Count > 0) then
  begin
    Runes := TStringList.Create;
    try
      RuneString := FDescription[0];
      Delete(RuneString, 1, Length('rune:'));
      RuneString := Trim(RuneString);
      Runes.DelimitedText := RuneString;
      Result := Runes.ToStringArray;
    finally
      Runes.Free;
    end;
  end;
end;

function TGameItem.GetDescription: string;
begin
  Result := FDescription.Text;
end;

function TGameItem.HasAllRequiredRunes(const RequiredRunes
  : TArray<string>): Boolean;
var
  ItemRunes: TArray<string>;
  I, R: Integer;
  RuneFound: Boolean;
begin
  Result := True;

  ItemRunes := ExtractRunes;
  for I := Low(ItemRunes) to High(ItemRunes) do
  begin
    RuneFound := False;
    for R := Low(RequiredRunes) to High(RequiredRunes) do
    begin
      if ItemRunes[I] = RequiredRunes[R] then
      begin
        RuneFound := True;
        Break;
      end;
    end;

    if not(RuneFound) then
      Exit(False);
  end;
end;

end.
