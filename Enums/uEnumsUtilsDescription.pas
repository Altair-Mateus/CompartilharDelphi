unit uEnumsUtilsDescription;

interface

uses
  System.SysUtils, System.TypInfo, System.Rtti, uEnumsUtils;

type

// Especifica que as informações RTTI serão geradas explicitamente para métodos
// com as visibilidades mencionadas
{$RTTI EXPLICIT METHODS([vcPrivate, vcProtected, vcPublic, vcPublished])}

  TEnumsUtilsDescription = class
    private
      // Retorna o nome do metodo
      function GetEnumMethodName<T> : String;
      // Retorna o metodo
      function GetEnumMethod(const TypeInfo: PTypeInfo; pName: String): TRttiMethod;

      //  Declaração das functions que irão retornar a descrição de acordo com o enum
      //  sempre Crie a mesma com o seguinte nome: Get + nome enumerador sem o T + Description
      function GetStatusCadastroDescription(pValue: TStatusCadastro) : String;
      function GetTipoLancamentoDescription(pvalue: TTipoLancamento) : String;
    public
      class function GetEnumDescription<T>(pEnum: T) : String; static;
  end;

implementation

  // Classe é usada para fornecer descrições personalizadas para valores de enumeradores.
  // Ela usa RTTI para buscar e invocar métodos que retornam essas descrições.
  // Os métodos de descrição, como GetStatusCadastroDescription, devem ser implementados
  // na própria classe para cada tipo de enumerador que você deseja suportar.

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
      Result := lMethod.Invoke(lEnumDesc, lEnumValue).AsString // Invoca o método e retorna a descrição
    else
      Result := GetEnumName(TypeInfo(T), Integer(lEnumValue.AsOrdinal)); // Retorna o nome padrão do enum se o método não for encontrado

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
    lType := lCtx.GetType(TEnumsUtilsDescription);  // Obtém o tipo da classe

    for lMethod in lType.GetMethods do
    begin
      if (lMethod.Name = pName) then // Verifica se o nome do método coincide
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

  // Obtém o nome do tipo e remove o "T" do início
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
