unit fMensagem;

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
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  uEnumsUtils,
  Vcl.WinXPanels;

type
  TfrmMensagem = class(TForm)
    pnlContainer: TPanel;
    pnlPrincipal: TPanel;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    pnlMensagem: TPanel;
    mmoMensagem: TMemo;
    cpnlImg: TCardPanel;
    cardErro: TCard;
    cardInformacao: TCard;
    pnlImgErro: TPanel;
    imgErro: TImage;
    cpnlBotao: TCardPanel;
    cardBotaoContinue: TCard;
    pnlPrincipalBotao: TPanel;
    pnlFundoBtn: TPanel;
    cardAviso: TCard;
    cardSucesso: TCard;
    pnlImgAviso: TPanel;
    imgAviso: TImage;
    pnlImgSucesso: TPanel;
    imgSucesso: TImage;
    pnlImgInformacao: TPanel;
    imgInformacao: TImage;
    cardBotaoEscolha: TCard;
    pnlBotaoOp: TPanel;
    pnlBtnSim: TPanel;
    pnlBtnNao: TPanel;
    cardEscolha: TCard;
    pnlImgEscolha: TPanel;
    imgEscolha: TImage;
    procedure FormShow(Sender: TObject);
    procedure pnlFundoBtnMouseEnter(Sender: TObject);
    procedure pnlFundoBtnMouseLeave(Sender: TObject);
    procedure pnlFundoBtnClick(Sender: TObject);
    procedure pnlBtnSimClick(Sender: TObject);
    procedure pnlBtnNaoClick(Sender: TObject);
    procedure pnlBtnSimMouseEnter(Sender: TObject);
    procedure pnlBtnSimMouseLeave(Sender: TObject);
    procedure pnlBtnNaoMouseEnter(Sender: TObject);
    procedure pnlBtnNaoMouseLeave(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FTipoTelaMsg: TTelaMensagem;
    FTitulo, FDescricao: String;
    FCorDestaque: Integer;
    FCorMouseEnter: Integer;

    procedure PreparaTela;
    procedure CarregaTelaErro;
    procedure CarregaTelaAviso;
    procedure CarregaTelaSucesso;
    procedure CarregaTelaInformacao;
    procedure CarregaTelaEscolha;
    procedure IniciaTelaMensagem;

    procedure EfeitoSaida;
    procedure FecharTela;
  public
    class procedure TelaMensagem(const pTitulo, pDescricao: String; const pTipoMensagem: TTelaMensagem);
    class function TelaEscolha(const pTitulo, pDescricao: String; const pTipoMensagem: TTelaMensagem): TModalResult;
  end;

var
  frmMensagem: TfrmMensagem;

implementation

uses
  System.Math;

{$R *.dfm}

{ TfrmMensagem }

procedure TfrmMensagem.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    if not(FTipoTelaMsg = tmEscolha) then
    begin
      FecharTela;
    end;
  end;
end;

procedure TfrmMensagem.FormShow(Sender: TObject);
begin
  IniciaTelaMensagem;
end;

procedure TfrmMensagem.pnlBtnNaoClick(Sender: TObject);
begin
  ModalResult := mrNo;
  EfeitoSaida;
end;

procedure TfrmMensagem.pnlBtnNaoMouseEnter(Sender: TObject);
begin
  pnlBtnNao.Color := $004A2FFF;
  pnlBtnNao.Update;
end;

procedure TfrmMensagem.pnlBtnNaoMouseLeave(Sender: TObject);
begin
  pnlBtnNao.Color := $006A53FF;
  pnlBtnNao.Update;
end;

procedure TfrmMensagem.pnlBtnSimClick(Sender: TObject);
begin
  ModalResult := mrYes;
  EfeitoSaida;
end;

procedure TfrmMensagem.pnlBtnSimMouseEnter(Sender: TObject);
begin
  pnlBtnSim.Color := $006A9D17;
  pnlBtnSim.Update;
end;

procedure TfrmMensagem.pnlBtnSimMouseLeave(Sender: TObject);
begin
  pnlBtnSim.Color := $0078B318;
  pnlBtnSim.Update;
end;

procedure TfrmMensagem.pnlFundoBtnClick(Sender: TObject);
begin
  FecharTela;
end;

procedure TfrmMensagem.pnlFundoBtnMouseEnter(Sender: TObject);
begin
  pnlFundoBtn.Color := FCorMouseEnter;
  pnlFundoBtn.Update;
end;

procedure TfrmMensagem.pnlFundoBtnMouseLeave(Sender: TObject);
begin
  pnlFundoBtn.Color := FCorDestaque;
  pnlFundoBtn.Update;
end;

procedure TfrmMensagem.PreparaTela;
begin
  lblTitulo.Caption := FTitulo;
  lblTitulo.Font.Color := FCorDestaque;
  mmoMensagem.Text := FDescricao;
  pnlFundoBtn.Font.Color := clWhite;
  pnlFundoBtn.Color := FCorDestaque;
  mmoMensagem.Font.Color := clBlack;
end;

procedure TfrmMensagem.CarregaTelaAviso;
begin
  cpnlImg.ActiveCard := cardAviso;
  cpnlBotao.ActiveCard := cardBotaoContinue;
  pnlImgAviso.Color := FCorDestaque;
end;

procedure TfrmMensagem.CarregaTelaErro;
begin
  cpnlImg.ActiveCard := cardErro;
  cpnlBotao.ActiveCard := cardBotaoContinue;
  pnlImgErro.Color := FCorDestaque;
end;

procedure TfrmMensagem.CarregaTelaEscolha;
begin
  cpnlImg.ActiveCard := cardEscolha;
  cpnlBotao.ActiveCard := cardBotaoEscolha;
  pnlImgEscolha.Color := clWhite;
end;

procedure TfrmMensagem.CarregaTelaInformacao;
begin
  cpnlImg.ActiveCard := cardInformacao;
  cpnlBotao.ActiveCard := cardBotaoContinue;
  pnlImgInformacao.Color := FCorDestaque;
end;

class procedure TfrmMensagem.TelaMensagem(const pTitulo, pDescricao: String; const pTipoMensagem: TTelaMensagem);
var
  lFormulario: TfrmMensagem;
begin

  lFormulario := TfrmMensagem.Create(nil);
  try
    lFormulario.FTitulo := pTitulo;
    lFormulario.FDescricao := pDescricao;
    lFormulario.FTipoTelaMsg := pTipoMensagem;
    lFormulario.ShowModal;
  finally
    lFormulario.Close;
    lFormulario.Free;
  end;

end;

class function TfrmMensagem.TelaEscolha(const pTitulo, pDescricao: String; const pTipoMensagem: TTelaMensagem)
  : TModalResult;
var
  lFormulario: TfrmMensagem;
begin

  Result := mrNone;

  lFormulario := TfrmMensagem.Create(nil);
  try
    lFormulario.FTitulo := pTitulo;
    lFormulario.FDescricao := pDescricao;
    lFormulario.FTipoTelaMsg := pTipoMensagem;
    lFormulario.ShowModal;
    Result := lFormulario.ModalResult;
  finally
    lFormulario.Close;
    lFormulario.Free;
  end;

end;

procedure TfrmMensagem.FecharTela;
begin
  ModalResult := mrOk;
  EfeitoSaida;
end;

procedure TfrmMensagem.IniciaTelaMensagem;
begin
  case FTipoTelaMsg of
    tmErro:
      begin
        FCorDestaque := $6A53FF;
        FCorMouseEnter := $4A2FFF;
        CarregaTelaErro;
      end;
    tmSucesso:
      begin
        FCorDestaque := $78B318;
        FCorMouseEnter := $6A9D17;
        CarregaTelaSucesso;
      end;
    tmAviso:
      begin
        FCorDestaque := $5BDDFF;
        FCorMouseEnter := $36D5FF;
        CarregaTelaAviso;
      end;
    tmInfo:
      begin
        FCorDestaque := $FF7152;
        FCorMouseEnter := $FF5E3B;
        CarregaTelaInformacao;
      end;
    tmEscolha:
      begin
        FCorDestaque := clBlack;
        CarregaTelaEscolha;
      end;
  end;
  PreparaTela;
end;

procedure TfrmMensagem.CarregaTelaSucesso;
begin
  cpnlImg.ActiveCard := cardSucesso;
  cpnlBotao.ActiveCard := cardBotaoContinue;
  pnlImgSucesso.Color := FCorDestaque;
end;

procedure TfrmMensagem.EfeitoSaida;
begin
  AlphaBlend := True;

  while (AlphaBlendValue > 0) do
  begin
    AlphaBlendValue := Max(0, AlphaBlendValue - 10);
    Application.ProcessMessages;
    Sleep(5);
  end;
end;

end.
