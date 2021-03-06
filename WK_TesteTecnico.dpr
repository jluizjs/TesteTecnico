program WK_TesteTecnico;

uses
  Vcl.Forms,
  WK_TesteTecnico.View.Principal in 'View\WK_TesteTecnico.View.Principal.pas' {frmPrincipal},
  WK_TesteTecnico.Model.DM in 'model\WK_TesteTecnico.Model.DM.pas' {DM: TDataModule},
  WK_TesteTecnico.Model.Produto in 'model\WK_TesteTecnico.Model.Produto.pas',
  WK_TesteTecnico.Model.Cliente in 'model\WK_TesteTecnico.Model.Cliente.pas',
  WK_TesteTecnico.Model.Pedido in 'model\WK_TesteTecnico.Model.Pedido.pas',
  WK_TesteTecnico.Model.ItensPedido in 'model\WK_TesteTecnico.Model.ItensPedido.pas',
  WK_TesteTecnico.Controller.Interfaces in 'controller\WK_TesteTecnico.Controller.Interfaces.pas',
  WK_TesteTecnico.Controller.Cliente in 'controller\WK_TesteTecnico.Controller.Cliente.pas',
  WK_TesteTecnico.Controller.Pedido in 'controller\WK_TesteTecnico.Controller.Pedido.pas',
  WK_TesteTecnico.Controller.Produto in 'controller\WK_TesteTecnico.Controller.Produto.pas',
  WK_TesteTecnico.Model.Interfaces in 'model\WK_TesteTecnico.Model.Interfaces.pas',
  WK_TesteTecnico.DAO.Pedido in 'DAO\WK_TesteTecnico.DAO.Pedido.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
