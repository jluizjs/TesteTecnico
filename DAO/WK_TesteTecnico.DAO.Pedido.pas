unit WK_TesteTecnico.DAO.Pedido;

interface

uses

   WK_TesteTecnico.Model.DM, WK_TesteTecnico.Model.Pedido;

type
  TDaoPedido = class
    private
      FConexao : TDM;
      FModelPedido : TModelPedido;
    public
      constructor Create;
      Destructor Destroy; override;
      procedure GravarPedido(pedido: TModelPedido);
      function NovoPedido(): Integer;
      function BuscarPedido(codigo: Integer): TModelPedido;
  end;

implementation

uses
  System.SysUtils, System.Variants;

{ TDaoPedido }

function TDaoPedido.BuscarPedido(codigo: Integer): TModelPedido;
begin

end;

constructor TDaoPedido.Create;
begin
  FConexao := TDM.Create(nil);
end;

procedure TDaoPedido.GravarPedido(pedido: TModelPedido);
var
  SQL: String;
  I: Integer;
begin
  FConexao.StartTransaction;
  try
    SQL := 'INSERT INTO PEDIDO VALUES (?,?,?,?)';
    FConexao.PrepareStatement(SQL);
    FConexao.SetValue(0, pedido.Codigo);
    FConexao.SetValue(1, pedido.DataEmissao);
    FConexao.SetValue(2, pedido.CodigoCliente);
    FConexao.SetValue(3, pedido.Total);
    FConexao.ExecSQL;
    SQL := '';
    for I := 0 to Pred(pedido.itensPedido.Count) do
    begin
      SQL := 'INSERT INTO PEDIDO_DETALHE (DET_PED_CODIGO, DET_PROD_CODIGO, '+
        'DET_QUANTIDADE, DET_VALOR_UNIT, DET_VALOR_TOTAL) VALUES (?,?,?,?,?)';
      FConexao.PrepareStatement(SQL);
      FConexao.SetValue(0, pedido.itensPedido[I].CodigoPedido);
      FConexao.SetValue(1, pedido.itensPedido[I].CodigoProduto);
      FConexao.SetValue(2, pedido.itensPedido[I].QuantidadeProduto);
      FConexao.SetValue(3, pedido.itensPedido[I].ValorUnitProduto);
      FConexao.SetValue(4, pedido.itensPedido[I].ValorTotal);
      FConexao.ExecSQL
    end;
    FConexao.Commit;
  except
    FConexao.RollBack;
  end;
end;

destructor TDaoPedido.Destroy;
begin
  FConexao.DisposeOf;
  inherited;
end;

function TDaoPedido.NovoPedido: Integer;
var
  value : Variant;
begin
  try
    value := DM.FDConnection.ExecSQLScalar(
      'SELECT MAX(PED_CODIGO) FROM PEDIDO');
    if (VarIsNull(value)) then
      Result := 1
    else
      Result := value +1;
  except
    raise Exception.Create('Erro ao buscar c�d. Pedido.');
  end;
end;

end.
