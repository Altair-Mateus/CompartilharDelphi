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
    Button1: TButton;
    procedure cbxComEfeitosDropDown(Sender: TObject);
    procedure cbxComEfeitosMouseEnter(Sender: TObject);
    procedure btnAlimentarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnLinkedinClick(Sender: TObject);
    procedure btnGithubClick(Sender: TObject);
  private
    procedure AlimentaCombo;
    procedure AlimentaComboComDefault;
    procedure LimparCombo;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}


uses
  uComboBoxHelper;

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

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin
  AlimentaComboComDefault;
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

end.
