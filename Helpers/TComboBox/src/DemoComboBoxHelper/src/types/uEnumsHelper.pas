unit uEnumsHelper;

interface

uses
  uEnums;

type
  TTipoUsuarioHelper = record helper for TTipoUsuario
    function Descricao: string;
  end;

implementation

{ TTipoUsuarioHelper }

function TTipoUsuarioHelper.Descricao: string;
begin
  case Self of
    tpuBalcao:
      Result := 'Balcão';
    tpuEscritorio:
      Result := 'Escritório';
    tpuGerente:
      Result := 'Gerente';
    tpuAdministrador:
      Result := 'Administrador';
  else
    Result := 'Não Identificado';
  end;
end;

end.
