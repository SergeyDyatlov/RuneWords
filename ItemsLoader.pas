unit ItemsLoader;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, GameItems;

type
  TItemsLoader = class
  private
    FItems: TObjectList<TGameItem>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFile(const FileName: string);
    function Filter(Accept: TFunc<TGameItem, Boolean>): TArray<TGameItem>;
    property Items: TObjectList<TGameItem> read FItems;
  end;

implementation

{ TItemsLoader }

constructor TItemsLoader.Create;
begin
  FItems := TObjectList<TGameItem>.Create(True);
end;

destructor TItemsLoader.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TItemsLoader.Filter(Accept: TFunc<TGameItem, Boolean>)
  : TArray<TGameItem>;
var
  Items: TList<TGameItem>;
begin
  Items := TList<TGameItem>.Create;
  try
    for var Item in FItems do
    begin
      if Accept(Item) then
        Items.Add(Item);
    end;
    Result := Items.ToArray;
  finally
    Items.Free;
  end;
end;

procedure TItemsLoader.LoadFromFile(const FileName: string);
var
  ItemDescriptions: TStringList;
begin
  ItemDescriptions := TStringList.Create;
  try
    ItemDescriptions.Delimiter := #13;
    ItemDescriptions.StrictDelimiter := True;
    ItemDescriptions.LineBreak := sLineBreak + sLineBreak;
    ItemDescriptions.LoadFromFile(FileName);

    for var ItemDescription in ItemDescriptions do
      FItems.Add(TGameItem.Create(ItemDescription));
  finally
    ItemDescriptions.Free;
  end;
end;

end.
