program ExemploComboBoxHelper;

uses
  Vcl.Forms,
  fPrincipal in 'src\view\fPrincipal.pas' {frmPrincipal},
  uComboBoxHelper in '..\Classes\uComboBoxHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
