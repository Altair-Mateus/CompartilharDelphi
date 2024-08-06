unit fMensagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, uEnumsUtils, Vcl.WinXPanels;

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
    procedure FormShow(Sender: TObject);
    procedure pnlFundoBtnMouseEnter(Sender: TObject);
    procedure pnlFundoBtnMouseLeave(Sender: TObject);
    procedure pnlFundoBtnClick(Sender: TObject);
  private
    FTipoMensagem: TTelaMensagem;
    FTitulo, FDescricao : String;
    FCorDestaque : Integer;
    FCorMouseEnter : Integer;
    procedure PreparaTela;
    procedure TelaErro;
    procedure TelaAviso;
    procedure TelaSucesso;
    procedure TelaInformacao;
  public
    class procedure TelaMensagem(pTitulo: String; pDescricao: String; pTipoMensagem: TTelaMensagem);
  end;

var
  frmMensagem: TfrmMensagem;

implementation

{$R *.dfm}

{ TfrmMensagem }

procedure TfrmMensagem.FormShow(Sender: TObject);
begin

  case FTipoMensagem of
    tmErro:
      begin
        FCorDestaque := $006A53FF;
        FCorMouseEnter := $004A2FFF;
        TelaErro;
      end;
    tmSucesso:
      begin
        FCorDestaque := $0078b318;
        FCorMouseEnter := $006a9d17;
        TelaSucesso;
      end;
    tmAviso:
      begin
        FCorDestaque := $005bddff;
        FCorMouseEnter := $0036d5ff;
        TelaAviso;
      end;
    tmInfo:
      begin
        FCorDestaque := $00ff7152;
        FCorMouseEnter := $00ff5e3b;
        TelaInformacao;
      end;
  end;

  PreparaTela;
end;

procedure TfrmMensagem.pnlFundoBtnClick(Sender: TObject);
begin
  ModalResult := mrOk;
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

procedure TfrmMensagem.TelaAviso;
begin
  cpnlImg.ActiveCard := cardAviso;
  cpnlBotao.ActiveCard := cardBotaoContinue;
  pnlImgAviso.Color := FCorDestaque;
end;

procedure TfrmMensagem.TelaErro;
begin
  cpnlImg.ActiveCard := cardErro;
  cpnlBotao.ActiveCard := cardBotaoContinue;
  pnlImgErro.Color := FCorDestaque;
end;

procedure TfrmMensagem.TelaInformacao;
begin
  cpnlImg.ActiveCard := cardInformacao;
  cpnlBotao.ActiveCard := cardBotaoContinue;
  pnlImgInformacao.Color := FCorDestaque;
end;

class procedure TfrmMensagem.TelaMensagem(pTitulo, pDescricao: String;
  pTipoMensagem: TTelaMensagem);
var
  lFormulario : TfrmMensagem;
begin

  lFormulario := TfrmMensagem.Create(nil);
  try
    lFormulario.FTitulo := pTitulo;
    lFormulario.FDescricao := pDescricao;
    lFormulario.FTipoMensagem := pTipoMensagem;
    lFormulario.ShowModal;
  finally
    lFormulario.Close;
    lFormulario.Free;
  end;

end;

procedure TfrmMensagem.TelaSucesso;
begin
  cpnlImg.ActiveCard := cardSucesso;
  cpnlBotao.ActiveCard := cardBotaoContinue;
  pnlImgSucesso.Color := FCorDestaque;
end;

end.
