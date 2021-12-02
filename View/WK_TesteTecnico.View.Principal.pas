unit WK_TesteTecnico.View.Principal;

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
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  WK_TesteTecnico.Controller.Interfaces,
  WK_TesteTecnico.Controller.Cliente,
  WK_TesteTecnico.Controller.Produto,
  WK_TesteTecnico.Controller.Pedido,
  WK_TesteTecnico.Model.Produto,
  WK_TesteTecnico.Model.Pedido, WK_TesteTecnico.Model.ItensPedido;

type
  TfrmPrincipal = class(TForm)
    pnlPrincipal: TPanel;
    pnlTopo: TPanel;
    pnlBottom: TPanel;
    pnlMenu: TPanel;
    dbgDetPedido: TDBGrid;
    btnGravarPedido: TButton;
    btnBuscarPedido: TButton;
    btnExcluirPedido: TButton;
    lblNomeCliente: TLabel;
    pnlCodigoPedido: TPanel;
    lblPedido: TLabel;
    btnSair: TButton;
    Label2: TLabel;
    btnNovoPedido: TButton;
    lblCliente: TLabel;
    pnlProduto: TPanel;
    edtValorUnitProduto: TLabeledEdit;
    btnInserirItem: TButton;
    edtQuantidadeProduto: TLabeledEdit;
    edtDescricaoProduto: TEdit;
    edtCodigoProduto: TLabeledEdit;
    lblProduto: TLabel;
    dsDetPedido: TDataSource;
    lblCodigoCliente: TLabel;
    lblCodigoPedido: TLabel;
    lblTotalPedido: TLabel;
    procedure btnInserirItemClick(Sender: TObject);
    procedure dbgDetPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure btnNovoPedidoClick(Sender: TObject);
    procedure edtCodigoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnBuscarPedidoClick(Sender: TObject);
    procedure btnExcluirPedidoClick(Sender: TObject);
  private
    { Private declarations }
    FControllerCliente: TControllerCliente;
    FControllerProduto: TControllerProduto;
    FControllerPedido: TControllerPedido;
    FProduto: TModelProduto;
    FPedido: TModelPedido;
    FItensPedido: TModelItensPedido;
    procedure InserirItemPedido();
    procedure LimparCamposItem();
    procedure BuscarProduto(codigo: Integer);
    procedure GerarPedido();
    procedure CalculcarTotal();
    procedure FinalizarPedido();
    procedure EditarItemPedido;
    procedure LiberaBloqueiaEdicao;
    procedure BloqueioInsertPedido;
    procedure ExcluirPedido;
    procedure BuscarPedido;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses
  WK_TesteTecnico.Model.DM;

procedure TfrmPrincipal.btnBuscarPedidoClick(Sender: TObject);
begin
  BuscarPedido;
end;

procedure TfrmPrincipal.btnExcluirPedidoClick(Sender: TObject);
begin
  ExcluirPedido;
end;

procedure TfrmPrincipal.btnGravarPedidoClick(Sender: TObject);
begin
  GerarPedido();
  FinalizarPedido;
end;

procedure TfrmPrincipal.btnInserirItemClick(Sender: TObject);
begin
  try
    InserirItemPedido();
    CalculcarTotal;
  except on E:exception do
    ShowMessage(E.Message);
  end;
  LimparCamposItem();
end;

procedure TfrmPrincipal.btnNovoPedidoClick(Sender: TObject);
var
  codigo: Integer;
begin
  FControllerCliente := TControllerCliente.Create;
  FControllerPedido := TControllerPedido.Create;
  try
    codigo := StrToInt(InputBox('C�dido do Cliente', 'Digite:', '0'));
    lblCodigoCliente.Caption := codigo.ToString;
    lblNomeCliente.Caption := 'Cliente: ' + FControllerCliente.BuscarCliente(codigo);
    lblCodigoPedido.Caption := FControllerPedido.NovoPedido.ToString;
    BloqueioInsertPedido;
    edtCodigoProduto.SetFocus;
  finally
    FControllerCliente.DisposeOf;
    FControllerPedido.DisposeOf;
  end;
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.BuscarProduto(codigo: Integer);
begin
  FControllerProduto := TControllerProduto.Create;
  FProduto := TModelProduto.Create;
  try
    FProduto := FControllerProduto.BuscarProduto(codigo);
    edtDescricaoProduto.Text := FProduto.Descricao;
    edtValorUnitProduto.Text := FProduto.PrecoVenda.ToString;
    edtQuantidadeProduto.SetFocus;
  finally
    FControllerProduto.DisposeOf;
    FProduto.DisposeOf;
  end;
end;

procedure TfrmPrincipal.CalculcarTotal;
var
  soma: Double;
begin
  soma := 0;
  dsDetPedido.DataSet.First;
  repeat
    soma := soma + dsDetPedido.DataSet.FieldByName('ValorTotal').AsFloat;
    dsDetPedido.DataSet.Next;
  until dsDetPedido.DataSet.Eof;
  lblTotalPedido.Caption := soma.ToString;
end;

procedure TfrmPrincipal.dbgDetPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    EditarItemPedido;
  end;
end;

procedure TfrmPrincipal.edtCodigoProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
    try
      BuscarProduto(StrToInt(edtCodigoProduto.Text));
    except
      raise Exception.Create('Erro ao buscar Produto.');
    end;
end;

procedure TfrmPrincipal.edtQuantidadeProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
    Key := #09;
end;

procedure TfrmPrincipal.edtValorUnitProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
    Key := #09;
end;

procedure TfrmPrincipal.FinalizarPedido;
begin
  LimparCamposItem;
  lblCodigoCliente.Caption := '';
  lblNomeCliente.Caption := '';
  lblCodigoPedido.Caption := '';
  lblTotalPedido.Caption := '';
  pnlProduto.Enabled := False;
  btnExcluirPedido.Enabled := True;
  btnBuscarPedido.Enabled := True;
end;

procedure TfrmPrincipal.EditarItemPedido;
begin
  dsDetPedido.DataSet.Edit;
  edtCodigoProduto.Text     := IntToStr(dsDetPedido.DataSet.FieldByName('Codigo').AsInteger);
  edtDescricaoProduto.Text  := dsDetPedido.DataSet.FieldByName('Descricao').AsString;
  edtQuantidadeProduto.Text := FloatToStr(dsDetPedido.DataSet.FieldByName('Quantidade').AsFloat);
  edtValorUnitProduto.Text  := FloatToStr(dsDetPedido.DataSet.FieldByName('ValorUnit').AsFloat);
  LiberaBloqueiaEdicao;
  edtQuantidadeProduto.SetFocus;
end;

procedure TfrmPrincipal.LiberaBloqueiaEdicao;
begin
  //
  if not (dsDetPedido.DataSet.State in [DsEdit]) then
  begin
    edtCodigoProduto.Enabled := True;
    edtDescricaoProduto.Enabled := True;
  end
  else
  begin
    edtCodigoProduto.Enabled := False;
    edtDescricaoProduto.Enabled := False;
  end;
end;

procedure TfrmPrincipal.BloqueioInsertPedido;
begin
  pnlProduto.Enabled := True;
  btnBuscarPedido.Enabled := False;
  btnExcluirPedido.Enabled := False;
end;

procedure TfrmPrincipal.ExcluirPedido;
var
  codigo: Integer;
begin
  FControllerPedido := TControllerPedido.Create;
  codigo := StrToInt(InputBox('Excluir Pedido', 'C�digo:', '0'));
  try
    if Application.MessageBox('Confirma Exclus�o do Pedido?', 'Confirma��o', MB_ICONWARNING + MB_YESNO) = mrYes then
      FControllerPedido.ExcluirPedido(codigo);
    Application.MessageBox('Pedido Excluido!', 'Mensagem do Sistema.', MB_ICONINFORMATION + MB_OK);
  finally
    FPedido.DisposeOf;
  end;
end;

procedure TfrmPrincipal.BuscarPedido;
var
  I: Integer;
begin
  FControllerPedido := TControllerPedido.Create;
  FPedido := TModelPedido.Create;
  try
    FPedido := FControllerPedido.BuscarPedido(StrToInt(InputBox('Buscar Pedido', 'C�digo do Pedido:', '0')));
    ShowMessage(FPedido.codigo.ToString);
    for I := 0 to Pred(FPedido.ItensPedido.Count) do
    begin
      ShowMessage(FPedido.ItensPedido[I].CodigoPedido.ToString);
    end;
  finally
    FControllerPedido.DisposeOf;
  end;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_UP then
    dsDetPedido.DataSet.Prior;
  if Key = VK_DOWN then
    dsDetPedido.DataSet.Next;
  if Key = VK_DELETE then
  begin
    if (Application.MessageBox('Confirma exclus�o?', 'Exclus�o de Itens',
      MB_ICONWARNING + MB_YESNO) = mrYes) then
    begin
      try
        dsDetPedido.DataSet.Delete;
        CalculcarTotal;
      except
        raise Exception.Create('Comando n�o pode ser executado.');
      end;
    end;
  end;
end;

procedure TfrmPrincipal.GerarPedido();
begin
  FPedido := TModelPedido.Create;
  FControllerPedido := TControllerPedido.Create;
  try
    FPedido.codigo := StrToInt(lblCodigoPedido.Caption);
    FPedido.DataEmissao := Now;
    FPedido.CodigoCliente := StrToInt(lblCodigoCliente.Caption);
    FPedido.Total := StrToFloat(lblTotalPedido.Caption);
    dsDetPedido.DataSet.First;
    while not dsDetPedido.DataSet.Eof do
    begin
      FItensPedido := TModelItensPedido.Create;
      FItensPedido.CodigoPedido := FPedido.codigo;
      FItensPedido.CodigoProduto := dsDetPedido.DataSet.FieldByName('Codigo').AsInteger;
      FItensPedido.Quantidade := dsDetPedido.DataSet.FieldByName('Quantidade').AsInteger;
      FItensPedido.ValorUnit := dsDetPedido.DataSet.FieldByName('ValorUnit').AsInteger;
      FItensPedido.ValorTotal := dsDetPedido.DataSet.FieldByName('ValorTotal').AsInteger;
      FPedido.ItensPedido.Add(FItensPedido);
      dsDetPedido.DataSet.Next;
    end;
    FControllerPedido.GravarPedido(FPedido);
  finally
    FPedido.DisposeOf;
    FItensPedido.DisposeOf;
    FControllerPedido.DisposeOf;
    Application.MessageBox('Pedido Salvo com Sucesso!', 'Mensagem do Sistema.',
      MB_ICONINFORMATION + MB_OK);
  end;
end;

procedure TfrmPrincipal.InserirItemPedido();
begin
  try
    if not(dsDetPedido.DataSet.state in [dsEdit]) then
    begin
      dsDetPedido.DataSet.Append;
      dsDetPedido.DataSet.FieldByName('Codigo').AsInteger :=
        StrToInt(edtCodigoProduto.Text);
      dsDetPedido.DataSet.FieldByName('Descricao').AsString :=
        edtDescricaoProduto.Text;
      dsDetPedido.DataSet.FieldByName('Quantidade').AsFloat :=
        StrToFloat(edtQuantidadeProduto.Text);
      dsDetPedido.DataSet.FieldByName('ValorUnit').AsFloat :=
        StrToFloat(edtValorUnitProduto.Text);
    end
    else
    begin
      dsDetPedido.DataSet.FieldByName('Codigo').AsInteger :=
        StrToInt(edtCodigoProduto.Text);
      dsDetPedido.DataSet.FieldByName('Descricao').AsString :=
        edtDescricaoProduto.Text;
      dsDetPedido.DataSet.FieldByName('Quantidade').AsFloat :=
        StrToFloat(edtQuantidadeProduto.Text);
      dsDetPedido.DataSet.FieldByName('ValorUnit').AsFloat :=
        StrToFloat(edtValorUnitProduto.Text);
    end;
    dsDetPedido.DataSet.Post;
    LiberaBloqueiaEdicao;
  finally
  end;
end;

procedure TfrmPrincipal.LimparCamposItem;
begin
  edtCodigoProduto.Clear;
  edtDescricaoProduto.Clear;
  edtQuantidadeProduto.Text := '1';
  edtValorUnitProduto.Clear;
  edtCodigoProduto.SetFocus;
end;

end.
