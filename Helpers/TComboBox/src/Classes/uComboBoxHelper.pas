unit uComboBoxHelper;

interface

uses
  Vcl.StdCtrls,
  Winapi.Windows,
  Vcl.Forms,
  Vcl.Controls,
  Winapi.Messages,
  System.UITypes,
  Vcl.Graphics,
  System.Classes,
  System.SysUtils;

type

  TComboBoxHelper = class helper for TComboBox
  private
    // Adiciona um item padrão na primeira posição
    procedure AddDefaultItem(const pDefaultText: string; const pSelectDefault: Boolean);
  public

    // Ajusta automaticamente a largura da lista suspensa (DropDown) conforme o maior item do ComboBox.
    // Recomenda-se chamar no evento OnDropDown do ComboBox.
    procedure AdjustDropDownWidth;

    // Exibe o texto atual do ComboBox como dica (Hint) ao passar o mouse.
    // Recomenda-se chamar no evento OnMouseEnter do ComboBox.
    procedure ShowTextHint;

    // Limpa os itens e define o itemIndex para -1
    procedure ClearAndReset;

    // Adiciona itens atraves de um array ou com TStrings
    procedure LoadFromStrings(const pStrings: TStrings; const pDefaultText: String = '';
      const pSelectDefault: Boolean = False); overload;
    procedure LoadFromStrings(const pValues: array of string; const pDefaultText: String = '';
      const pSelectDefault: Boolean = False); overload;

    function TryGetEnum<T>(out pOutValue: T): Boolean;
    function TrySetEnum<T>(const pValue: T): Boolean;
  end;

implementation

uses
  System.Rtti,
  System.TypInfo;

{ TComboBoxHelper }

procedure TComboBoxHelper.AdjustDropDownWidth;
var
  I, lMaxWidth, lTextWidth: Integer;
begin
  // Se o combo estiver vazio, não há o que ajustar
  if (Items.Count = 0) then
    Exit;

  lMaxWidth := 0;

  // Usa a mesma fonte do ComboBox para medir os textos
  Canvas.Font.Assign(Font);

  // Percorre todos os itens e mede o texto para encontrar o mais largo
  for I := 0 to Items.Count - 1 do
  begin
    lTextWidth := Canvas.TextWidth(Items[I]);

    // Armazena o maior tamanho encontrado
    if (lTextWidth > lMaxWidth) then
      lMaxWidth := lTextWidth;
  end;

  // Adiciona uma margem extra e considera a largura da barra de rolagem vertical
  lMaxWidth := (lMaxWidth + GetSystemMetrics(SM_CXVSCROLL) + 16);

  // Limita a largura máxima a metade da tela (evita lista exageradamente larga)
  if (lMaxWidth > Screen.Width div 2) then
    lMaxWidth := (Screen.Width div 2);

  // Envia mensagem para o Windows ajustar a largura da lista suspensa
  SendMessage(Handle, CB_SETDROPPEDWIDTH, lMaxWidth, 0);
end;

procedure TComboBoxHelper.ClearAndReset;
begin
  Items.Clear;
  ItemIndex := -1;
end;

procedure TComboBoxHelper.LoadFromStrings(const pValues: array of string; const pDefaultText: String = '';
  const pSelectDefault: Boolean = False);
var
  lValue: string;
begin
  Items.BeginUpdate;
  try
    Items.Clear;

    AddDefaultItem(pDefaultText, pSelectDefault);

    for lValue in pValues do
    begin
      Items.Add(lValue);
    end;

  finally
    Items.EndUpdate;
  end;

end;

procedure TComboBoxHelper.AddDefaultItem(const pDefaultText: string; const pSelectDefault: Boolean);
begin
  // Adiciona item padrão, se informado
  if not(pDefaultText.Trim.IsEmpty) then
  begin
    Items.Add(pDefaultText);
    if pSelectDefault then
      ItemIndex := 0;
  end
  else
  begin
    ItemIndex := -1;
  end;
end;

procedure TComboBoxHelper.ShowTextHint;
begin
  // Define o Hint (dica) como o texto atual exibido no ComboBox
  Hint := Text;

  // Ativa a exibição de dicas
  ShowHint := True;

  // Força o aparecimento imediato da dica na posição atual do mouse
  Application.ActivateHint(Mouse.CursorPos);
end;

function TComboBoxHelper.TryGetEnum<T>(out pOutValue: T): Boolean;
begin
  Result := False;

  pOutValue := Default (T);

  if (ItemIndex < 0) then
    Exit;

  if (Items.Objects[ItemIndex] = nil) then
    Exit;

  if (PTypeInfo(TypeInfo(T))^.Kind <> tkEnumeration) then
    Exit;

  try
    pOutValue := TValue.FromOrdinal(TypeInfo(T), NativeInt(Items.Objects[ItemIndex])).AsType<T>;
    Result := True;
  except
    on E: Exception do
    begin
      Result := False;
    end;
  end;
end;

function TComboBoxHelper.TrySetEnum<T>(const pValue: T): Boolean;
var
  I: Integer;
  lOrdValue: NativeInt;
begin

  Result := False;

  if (PTypeInfo(TypeInfo(T))^.Kind <> tkEnumeration) then
    Exit;

  lOrdValue := TValue.From<T>(pValue).AsOrdinal;

  for I := 0 to Items.Count - 1 do
  begin
    if (NativeInt(Items.Objects[I]) = lOrdValue) then
    begin
      ItemIndex := I;
      Exit(True);
    end;
  end;

  ItemIndex := -1;

end;

procedure TComboBoxHelper.LoadFromStrings(const pStrings: TStrings; const pDefaultText: String = '';
  const pSelectDefault: Boolean = False);
begin
  if not Assigned(pStrings) then
    Exit;

  Items.BeginUpdate;
  try
    Items.Clear;

    AddDefaultItem(pDefaultText, pSelectDefault);
    Items.AddStrings(pStrings);

  finally
    Items.EndUpdate;
  end;
end;

end.
