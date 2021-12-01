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
  private
    { Private declarations }
    FControllerCliente : TControllerCliente;
    FControllerProduto : TControllerProduto;
    FControllerPedido : TControllerPedido;
    FProduto : TModelProduto;
    FPedido : TModelPedido;
    FItensPedido: TModelItensPedido;
    procedure InserirItemPedido();
    procedure LimparCamposItem();
    procedure BuscarProduto(codigo: Integer);
    procedure GerarPedido(pedido : TModelPedido);
    procedure CalculcarTotal();
    procedure FinalizarPedido();
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
  FControllerPedido := TControllerPedido.Create;
  try
    FControllerPedido.BuscarPedido(StrToInt(InputBox('Buscar Pedido','C�digo do Pedido:','0')));
  finally
    FControllerPedido.DisposeOf;
  end;
end;

procedure TfrmPrincipal.btnGravarPedidoClick(Sender: TObject);
begin
  FControllerPedido := TControllerPedido.Create;
  FPedido := TModelPedido.Create;
  try
    GerarPedido(FPedido);
    FControllerPedido.GravarPedido(FPedido);
    FinalizarPedido;
  finally
    FControllerPedido.DisposeOf;
    FPedido.DisposeOf;
  end;
end;

procedure TfrmPrincipal.btnInserirItemClick(Sender: TObject);
begin
  InserirItemPedido();
  LimparCamposItem();
  CalculcarTotal;
end;

procedure TfrmPrincipal.btnNovoPedidoClick(Sender: TObject);
var
  codigo : Integer;
begin
  FControllerCliente := TControllerCliente.Create;
  FControllerPedido := TControllerPedido.Create;
  try
    codigo := StrToInt(InputBox('C�dido do Cliente','Digite:','0'));
    lblCodigoCliente.Caption := codigo.ToString;
    lblNomeCliente.Caption   := 'Cliente: ' + FControllerCliente.BuscarCliente(codigo);
    lblCodigoPedido.Caption  := FControllerPedido.NovoPedido.ToString;
    pnlProduto.Enabled := True;
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
    soma := soma + dsDetPedido.DataSet.FieldByName('DET_VALOR_TOTAL').AsFloat;
    dsDetPedido.DataSet.Next;
  until dsDetPedido.DataSet.Eof;
  lblTotalPedido.Caption := soma.ToString;
end;

procedure TfrmPrincipal.dbgDetPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    dbgDetPedido.Options := dbgDetPedido.Options + [dgEditing];
end;

procedure TfrmPrincipal.edtCodigoProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key = #13) then
    BuscarProduto(strToInt(edtCodigoProduto.Text));
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
  lblNomeCliente.Caption   := '';
  lblCodigoPedido.Caption  := '';
  pnlProduto.Enabled := False;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_UP then
    dsDetPedido.DataSet.Prior;
  if key = VK_DOWN then
    dsDetPedido.DataSet.Next;
  if key = VK_DELETE then
  begin
    if (Application.MessageBox('Confirma exclus�o?','Exclus�o de Itens',MB_ICONWARNING + MB_YESNO) = mrYes) then
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

procedure TfrmPrincipal.GerarPedido(pedido : TModelPedido);
begin
  FPedido := TModelPedido.Create;
  FControllerPedido := TControllerPedido.Create;
  FItensPedido := TModelItensPedido.Create;
  try
    FPedido.Codigo  := StrToInt(lblCodigoPedido.Caption);
    FPedido.DataEmissao := Now;
    FPedido.CodigoCliente := StrToInt(lblCodigoCliente.Caption);
    FPedido.Total := StrToFloat(lblTotalPedido.Caption);
    dsDetPedido.DataSet.First;
    while not dsDetPedido.DataSet.Eof do
    begin
      FItensPedido.CodigoPedido      := FPedido.Codigo;
      FItensPedido.CodigoProduto     := dsDetPedido.DataSet.FieldByName('det_prod_codigo').AsInteger;
      FItensPedido.QuantidadeProduto := dsDetPedido.DataSet.FieldByName('det_prod_quantidade').AsInteger;
      FItensPedido.ValorUnitProduto  := dsDetPedido.DataSet.FieldByName('det_valor_unit').AsInteger;
      FItensPedido.ValorTotal        := dsDetPedido.DataSet.FieldByName('det_valor_total').AsInteger;
      FPedido.itensPedido.Add(FItensPedido);
      dsDetPedido.DataSet.Next;
    end;
    FControllerPedido.GravarPedido(FPedido);
  finally
    FPedido.DisposeOf;
    FItensPedido.DisposeOf;
    FControllerPedido.DisposeOf;
  end;
end;

procedure TfrmPrincipal.InserirItemPedido();
begin
  try
    DM.cdsDetPedido.Append;
    DM.cdsDetPedidodet_prod_codigo.AsInteger      := StrToInt(edtCodigoProduto.Text);
    DM.cdsDetPedidodet_prod_descricao.AsString    := edtDescricaoProduto.Text;
    DM.cdsDetPedidodet_prod_quantidade.AsFloat    := StrToFloat(edtQuantidadeProduto.Text);
    DM.cdsDetPedidodet_valor_unit.AsFloat         := StrToFloat(edtValorUnitProduto.Text);
    DM.cdsDetPedido.Post;
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