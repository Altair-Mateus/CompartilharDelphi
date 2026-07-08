program ExemploComboBoxHelper;

uses
  Vcl.Forms,
  fPrincipal in 'src\view\fPrincipal.pas' {frmPrincipal},
  uComboBoxHelper in '..\Classes\uComboBoxHelper.pas',
  uUsuarioExemplo in 'src\model\uUsuarioExemplo.pas',
  uEnums in 'src\types\uEnums.pas',
  uEnumsHelper in 'src\types\uEnumsHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
