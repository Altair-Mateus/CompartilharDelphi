unit fPrincipal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  ShellAPI;

type
  TfrmPrincipal = class(TForm)
    pnlContainer: TPanel;
    pnlTitulo: TPanel;
    pnlInferior: TPanel;
    lblDev: TLabel;
    btnGithub: TButton;
    btnLinkedin: TButton;
    pnlCombos: TPanel;
    lblCbxSemEfeitos: TLabel;
    cbxSemEfeito: TComboBox;
    lblCbxComEfeitos: TLabel;
    cbxComEfeitos: TComboBox;
    btnAlimentar: TButton;
    btnLimpar: TButton;
    btnAlimentaDefaulr: TButton;
    btnAlimentaComEnum: TButton;
    btnPuxaEnum: TButton;
    btnSetEnum: TButton;
    procedure cbxComEfeitosDropDown(Sender: TObject);
    procedure cbxComEfeitosMouseEnter(Sender: TObject);
    procedure btnAlimentarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlimentaDefaulrClick(Sender: TObject);
    procedure btnLinkedinClick(Sender: TObject);
    procedure btnGithubClick(Sender: TObject);
    procedure btnAlimentaComEnumClick(Sender: TObject);
    procedure btnPuxaEnumClick(Sender: TObject);
    procedure btnSetEnumClick(Sender: TObject);
  private
    procedure AlimentaCombo;
    procedure AlimentaComboComDefault;
    procedure AlimentaComEnum;
    procedure PuxarEnumCombo;
    procedure SelecionarEnumUser;
    procedure LimparCombo;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}


uses
  uComboBoxHelper,
  uEnums,
  System.Math,
  uEnumsHelper,
  uUsuarioExemplo,
  System.TypInfo;

procedure TfrmPrincipal.AlimentaCombo;
begin
  LimparCombo;
  cbxComEfeitos.LoadFromStrings([
    'Opção 1',
    'Opção com texto mais longo',
    'Uma opção absurdamente longa só pra testar o ajuste automático',
    'Curta',
    'Opção intermediária'
    ])
end;

procedure TfrmPrincipal.AlimentaComboComDefault;
begin
  LimparCombo;
  cbxComEfeitos.LoadFromStrings([
    'Opção 1',
    'Opção com texto mais longo',
    'Uma opção absurdamente longa só pra testar o ajuste automático',
    'Curta',
    'Opção intermediária'
    ],
    'Selecione', // Item Padrão na primeira posição
    True // Coloca o itemindex no item padrão
    );

end;

procedure TfrmPrincipal.AlimentaComEnum;
var
  lTipoUsuario: TTipoUsuario;
begin

  cbxComEfeitos.Items.BeginUpdate;
  try

    cbxComEfeitos.Items.Clear;
    cbxComEfeitos.Items.AddObject('Selecione', TObject(NativeInt(tpuNaoIdentificado)));
    for lTipoUsuario := tpuBalcao to High(TTipoUsuario) do
    begin
      cbxComEfeitos.Items.AddObject(
        lTipoUsuario.Descricao,
        TObject(NativeInt(lTipoUsuario))
        )
    end;

  finally
    cbxComEfeitos.Items.EndUpdate;
    cbxComEfeitos.ItemIndex := IfThen((cbxComEfeitos.Items.Count > 0), 1, 0);
  end;

end;

procedure TfrmPrincipal.btnAlimentaComEnumClick(Sender: TObject);
begin
  AlimentaComEnum;
end;

procedure TfrmPrincipal.btnAlimentarClick(Sender: TObject);
begin
  AlimentaCombo;
end;

procedure TfrmPrincipal.btnGithubClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'https://github.com/Altair-Mateus', nil, nil,
    SW_SHOWNORMAL);
end;

procedure TfrmPrincipal.btnLimparClick(Sender: TObject);
begin
  LimparCombo;
end;

procedure TfrmPrincipal.btnLinkedinClick(Sender: TObject);
begin
  ShellExecute(0, 'open',
    'https://www.linkedin.com/in/altair-mateus-t-alencastro/', nil, nil,
    SW_SHOWNORMAL);
end;

procedure TfrmPrincipal.btnPuxaEnumClick(Sender: TObject);
begin
  PuxarEnumCombo;
end;

procedure TfrmPrincipal.btnAlimentaDefaulrClick(Sender: TObject);
begin
  AlimentaComboComDefault;
end;

procedure TfrmPrincipal.btnSetEnumClick(Sender: TObject);
begin
  SelecionarEnumUser;
end;

procedure TfrmPrincipal.cbxComEfeitosDropDown(Sender: TObject);
begin
  cbxComEfeitos.AdjustDropDownWidth;
end;

procedure TfrmPrincipal.cbxComEfeitosMouseEnter(Sender: TObject);
begin
  cbxComEfeitos.ShowTextHint;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  AlimentaCombo;
end;

procedure TfrmPrincipal.LimparCombo;
begin
  cbxComEfeitos.ClearAndReset;
end;

procedure TfrmPrincipal.PuxarEnumCombo;
var
  lUsuario: TUsuarioExemplo;
  lTipoUsuario: TTipoUsuario;
begin
  lUsuario := TUsuarioExemplo.Create;
  try

    lUsuario.Nome := 'Altair Mateus';

    // Puxa o Enum selecionado do combo
    if (cbxComEfeitos.TryGetEnum<TTipoUsuario>(lTipoUsuario)) then
    begin
      lUsuario.Tipo := lTipoUsuario;
      ShowMessage(GetEnumName(TypeInfo(TTipoUsuario), Ord(lTipoUsuario)));
    end;
    lUsuario.Salvar;

  finally
    lUsuario.Free;
  end;
end;

procedure TfrmPrincipal.SelecionarEnumUser;
var
  lUsuario: TUsuarioExemplo;
  lTipoUsuario: TTipoUsuario;
begin
  lUsuario := TUsuarioExemplo.Create;
  try

    lUsuario.Nome := 'Altair Mateus';
    lUsuario.Tipo := tpuGerente;

    // Puxa o Enum da entidade e seleciona o mesmo
    cbxComEfeitos.TrySetEnum<TTipoUsuario>(lUsuario.Tipo);

  finally
    lUsuario.Free;
  end;

end;

end.
