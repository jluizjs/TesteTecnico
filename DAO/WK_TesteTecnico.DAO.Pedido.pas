unit WK_TesteTecnico.DAO.Pedido;

interface

uses

   WK_TesteTecnico.Model.DM,
   WK_TesteTecnico.Model.Pedido,
   WK_TesteTecnico.Model.ItensPedido;

type
  TDaoPedido = class
    private
      FConexao : TDM;
      FPedido : TModelPedido;
      FItensPedido : TModelItensPedido;
    public
      constructor Create;
      Destructor Destroy; override;
      procedure GravarPedido(pedido: TModelPedido);
      function NovoPedido(): Integer;
      function BuscarPedido(codigo: Integer): TModelPedido;
      procedure ExcluirPedido(codigo: Integer);
  end;

implementation

uses
  System.SysUtils, System.Variants, Data.DB, FireDAC.Comp.Client;

{ TDaoPedido }

function TDaoPedido.BuscarPedido(codigo: Integer): TModelPedido;
var
  SQL : String;
  I : Integer;
begin
  FPedido := TModelPedido.Create;
  try
    SQL := 'SELECT * FROM PEDIDO WHERE CODIGO='+codigo.ToString;
    FConexao.FDQuery.SQL.Clear;
    FConexao.FDQuery.SQL.Add( SQL);
    FConexao.FDQuery.Open;
    if FConexao.FDQuery.RecordCount > 0 then
    begin
      FPedido.Codigo := FConexao.FDQuery.FieldByName('CODIGO').AsInteger;
      FPedido.CodigoCliente := FConexao.FDQuery.FieldByName('CODIGO_CLIENTE').AsInteger;
      FPedido.Total := FConexao.FDQuery.FieldByName('TOTAL').AsFloat;
      //
      SQL := 'SELECT * FROM PEDIDO_DETALHE WHERE CODIGO_PEDIDO='+codigo.ToString;
      FConexao.FDQuery.SQL.Clear;
      FConexao.FDQuery.SQL.Add(SQL);
      FConexao.FDQuery.Open;
      if FConexao.FDQuery.RecordCount > 0 then
      begin
        FConexao.FDQuery.First;
        for I := 0 to pred(FConexao.FDQuery.RecordCount) do
        begin
          FItensPedido := TModelItensPedido.Create;
          FItensPedido.CodigoPedido  := FConexao.FDQuery.FieldByName('CODIGO_PEDIDO').AsInteger;
          FItensPedido.CodigoProduto := FConexao.FDQuery.FieldByName('CODIGO_PRODUTO').AsInteger;
          FItensPedido.Quantidade    := FConexao.FDQuery.FieldByName('QUANTIDADE').AsFloat;
          FItensPedido.ValorUnit     := FConexao.FDQuery.FieldByName('VALOR_UNIT').AsFloat;
          FItensPedido.ValorTotal    := FConexao.FDQuery.FieldByName('VALOR_TOTAL').AsFloat;
          FPedido.ItensPedido.Add(FItensPedido);
        end;
      end;
      Result := FPedido;
    end
    else
      raise Exception.Create('Pedido n�o encontrado!');
  finally
    FPedido.DisposeOf;
    FItensPedido.DisposeOf;
  end;
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

    for I := 0 to Pred(pedido.ItensPedido.Count) do
    begin
      SQL := 'INSERT INTO PEDIDO_DETALHE (CODIGO_PEDIDO, CODIGO_PRODUTO, '+
        'QUANTIDADE, VALOR_UNIT, VALOR_TOTAL) VALUES (?,?,?,?,?)';
      FConexao.PrepareStatement(SQL);
      FConexao.SetValue(0, pedido.itensPedido[I].CodigoPedido);
      FConexao.SetValue(1, pedido.itensPedido[I].CodigoProduto);
      FConexao.SetValue(2, pedido.itensPedido[I].Quantidade);
      FConexao.SetValue(3, pedido.itensPedido[I].ValorUnit);
      FConexao.SetValue(4, pedido.itensPedido[I].ValorTotal);
      FConexao.ExecSQL
    end;
    FConexao.Commit;
    DM.cdsDetPedido.EmptyDataSet;
  except
    FConexao.RollBack;
  end;
end;

destructor TDaoPedido.Destroy;
begin
  FConexao.DisposeOf;
  inherited;
end;

procedure TDaoPedido.ExcluirPedido(codigo: Integer);
var
  SQL: String;
begin
  FConexao.StartTransaction;
  try
    SQL := 'DELETE FROM PEDIDO_DETALHE WHERE CODIGO_PEDIDO = ?';
    FConexao.PrepareStatement(SQL);
    FConexao.SetValue(0, codigo);
    FConexao.ExecSQL;
    SQL := '';
    SQL := 'DELETE FROM PEDIDO WHERE CODIGO = ?';
    FConexao.PrepareStatement(SQL);
    FConexao.SetValue(0, codigo);
    FConexao.ExecSQL;
    FConexao.Commit;
  except
    FConexao.RollBack;
  end;
end;

function TDaoPedido.NovoPedido: Integer;
var
  value : Variant;
begin
  try
    value := DM.FDConnection.ExecSQLScalar(
      'SELECT MAX(CODIGO) FROM PEDIDO');
    if (VarIsNull(value)) then
      Result := 1
    else
      Result := value +1;
  except
    raise Exception.Create('Erro ao buscar c�d. Pedido.');
  end;
end;

end.
