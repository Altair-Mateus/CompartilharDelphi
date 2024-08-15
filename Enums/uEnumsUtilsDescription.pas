unit uEnumsUtilsDescription;

interface

uses
  System.SysUtils, System.TypInfo, System.Rtti, uEnumsUtils;

type

// Especifica que as informa��es RTTI ser�o geradas explicitamente para m�todos
// com as visibilidades mencionadas
{$RTTI EXPLICIT METHODS([vcPrivate, vcProtected, vcPublic, vcPublished])}

  TEnumsUtilsDescription = class
    private
      // Retorna o nome do metodo
      function GetEnumMethodName<T> : String;
      // Retorna o metodo
      function GetEnumMethod(const TypeInfo: PTypeInfo; pName: String): TRttiMethod;

      //  Declara��o das functions que ir�o retornar a descri��o de acordo com o enum
      //  sempre Crie a mesma com o seguinte nome: Get + nome enumerador sem o T + Description
      function GetStatusCadastroDescription(pValue: TStatusCadastro) : String;
      function GetTipoLancamentoDescription(pvalue: TTipoLancamento) : String;
    public
      class function GetEnumDescription<T>(pEnum: T) : String; static;
  end;

implementation

  // Classe � usada para fornecer descri��es personalizadas para valores de enumeradores.
  // Ela usa RTTI para buscar e invocar m�todos que retornam essas descri��es.
  // Os m�todos de descri��o, como GetStatusCadastroDescription, devem ser implementados
  // na pr�pria classe para cada tipo de enumerador que voc� deseja suportar.

class function TEnumsUtilsDescription.GetEnumDescription<T>(pEnum: T): String;
var
  lEnumValue: TValue;
  lEnumDesc : TEnumsUtilsDescription;
  lMethodName : String;
  lMethod: TRttiMethod;
begin

  lEnumDesc := TEnumsUtilsDescription.Create;
  try
    lEnumValue := TValue.From<T>(pEnum); // Converte o valor do enumerador para TValue
    lMethodName := lEnumDesc.GetEnumMethodName<T>;
    lMethod := lEnumDesc.GetEnumMethod(TypeInfo(T), lMethodName);

    if Assigned(lMethod) then
      Result := lMethod.Invoke(lEnumDesc, lEnumValue).AsString // Invoca o m�todo e retorna a descri��o
    else
      Result := GetEnumName(TypeInfo(T), Integer(lEnumValue.AsOrdinal)); // Retorna o nome padr�o do enum se o m�todo n�o for encontrado

  finally
    lEnumDesc.Free;
  end;

end;

function TEnumsUtilsDescription.GetEnumMethod(
  const TypeInfo: pTypeInfo; pName : String): TRttiMethod;
var
  lCtx: TRttiContext;
  lType: TRttiType;
  lMethod: TRttiMethod;
begin
  Result := nil;
  lCtx := TRttiContext.Create;
  try
    lType := lCtx.GetType(TEnumsUtilsDescription);  // Obt�m o tipo da classe

    for lMethod in lType.GetMethods do
    begin
      if (lMethod.Name = pName) then // Verifica se o nome do m�todo coincide
      begin
        Result := lMethod; // Retorna o metodo encontrado
        break;
      end;
    end;

  finally
    lCtx.Free;
  end;
end;

function TEnumsUtilsDescription.GetEnumMethodName<T>: String;
var
  lTypeName : String;
begin

  // Obt�m o nome do tipo e remove o "T" do in�cio
  lTypeName := String(PTypeInfo(System.TypeInfo(T))^.Name);
  if (lTypeName.Chars[0] = 'T') then
    lTypeName := lTypeName.Substring(1);

  // Retorna o nome do metodos de acordo com o enumerador
  Result := 'Get' + lTypeName + 'Description';
end;

function TEnumsUtilsDescription.GetStatusCadastroDescription(
  pValue: TStatusCadastro): string;
begin
  case pValue of
    scInativo:
      Result := 'Inativo';
    scAtivo:
      Result := 'Ativo';
  else
    Result := 'Desconhecido';
  end;
end;

function TEnumsUtilsDescription.GetTipoLancamentoDescription(
  pvalue: TTipoLancamento): String;
begin
  case pvalue of
    tlCr:
      Result := 'Contas a Receber';
    tlCp:
      Result := 'Contas a Pagar';
    tlCx:
      Result := 'Caixa';
    tlTodos:
      Result := 'Todos';
  else
    Result := 'Desconhecido';
  end;
end;

end.
