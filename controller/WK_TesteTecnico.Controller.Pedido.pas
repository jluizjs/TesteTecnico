unit WK_TesteTecnico.Controller.Pedido;

interface

uses
  WK_TesteTecnico.Controller.Interfaces,
  WK_TesteTecnico.Model.Produto,
  WK_TesteTecnico.Model.Pedido,
  WK_TesteTecnico.DAO.Pedido,
  Data.DB;

type
  TControllerPedido = class(TInterfacedObject, iControllerPedido)
    private
      FDaoPedido : TDaoPedido;
    public
      constructor Create;
      Destructor Destroy; override;
      procedure GravarPedido(Pedido: TModelPedido);
      function NovoPedido(): Integer;
      procedure BuscarPedido(pedido: TModelPedido; DataSet : TDataSet);
      procedure ExcluirPedido(codigo: Integer);
  end;

implementation

uses
  WK_TesteTecnico.Controller.Produto;

{ TControllerPedido }

procedure TControllerPedido.BuscarPedido(pedido: TModelPedido; DataSet: TDataSet);
begin
  FDaoPedido := TDaoPedido.Create;
  try
    FDaoPedido.BuscarPedido(pedido, DataSet );
  finally
    FDaoPedido.DisposeOf;
  end;
end;

constructor TControllerPedido.Create;
begin

end;

destructor TControllerPedido.Destroy;
begin

  inherited;
end;

procedure TControllerPedido.ExcluirPedido(codigo: Integer);
begin
  FDaoPedido := TDaoPedido.Create;
  try
    FDaoPedido.ExcluirPedido(codigo);
  finally
    FDaoPedido.DisposeOf;
  end;
end;

procedure TControllerPedido.GravarPedido(pedido: TModelPedido);
begin
  FDaoPedido := TDaoPedido.Create;
  try
    FDaoPedido.GravarPedido(pedido);
  finally
    FDaoPedido.DisposeOf;
  end;
end;

function TControllerPedido.NovoPedido: Integer;
begin
  FDaoPedido := TDaoPedido.Create;
  try
    Result := FDaoPedido.NovoPedido();
  finally
    FDaoPedido.DisposeOf;
  end;
end;

end.
