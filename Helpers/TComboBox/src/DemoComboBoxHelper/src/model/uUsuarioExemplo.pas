unit uUsuarioExemplo;

interface

uses
  uEnums;

type

  TUsuarioExemplo = class
  private
    FNome: string;
    FLogin: string;
    FSenha: string;
    FTipo: TTipoUsuario;
  public
    property Nome: string read FNome write FNome;
    property Login: string read FLogin write FLogin;
    property Senha: string read FSenha write FSenha;
    property Tipo: TTipoUsuario read FTipo write FTipo;

    function Salvar: Boolean;
  end;

implementation

{ TUsuarioExemplo }

function TUsuarioExemplo.Salvar: Boolean;
begin
  Result := True;
  // TODO: somente de testes
end;

end.
