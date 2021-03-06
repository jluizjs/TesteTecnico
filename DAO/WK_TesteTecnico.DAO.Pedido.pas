unit WK_TesteTecnico.DAO.Pedido;

interface

uses

   WK_TesteTecnico.Model.DM,
   WK_TesteTecnico.Model.Pedido,
   WK_TesteTecnico.Model.ItensPedido,
   Data.DB;

type
  TDaoPedido = class
    private
      DM : TDM;
      FPedido : TModelPedido;
      FItensPedido : TModelItensPedido;
    public
      constructor Create;
      Destructor Destroy; override;
      procedure GravarPedido(pedido: TModelPedido);
      function NovoPedido(): Integer;
      procedure BuscarPedido(pedido: TModelPedido; DataSet: TDataSet);
      procedure ExcluirPedido(codigo: Integer);
  end;

implementation

uses
  System.SysUtils, System.Variants, FireDAC.Comp.Client;

{ TDaoPedido }

procedure TDaoPedido.BuscarPedido(pedido: TModelPedido; DataSet:  TDataSet);
var
  I : Integer;
begin
  try
    DM.FDQuery.SQL.Clear;
    DM.FDQuery.SQL.Add('SELECT * FROM PEDIDO WHERE CODIGO= :CODIGO');
    DM.FDQuery.ParamByName('CODIGO').AsInteger := Pedido.Codigo;
    DM.FDQuery.Open;
    if DM.FDQuery.RecordCount > 0 then
    begin
      Pedido.DataEmissao := DM.FDQuery.FieldByName('DATA_EMISSAO').AsDateTime;
      Pedido.CodigoCliente := DM.FDQuery.FieldByName('CODIGO_CLIENTE').AsInteger;
      Pedido.Total := DM.FDQuery.FieldByName('TOTAL').AsFloat;
      //
      DM.FDQuery.SQL.Clear;
      DM.FDQuery.SQL.Add(
        'SELECT P.CODIGO, P.DESCRICAO, PD.QUANTIDADE, PD.VALOR_UNIT, PD.VALOR_TOTAL '+
        'FROM PEDIDO_DETALHE  PD '+
        'INNER JOIN PRODUTO P on P.CODIGO = pd.CODIGO_PRODUTO '+
        'WHERE CODIGO_PEDIDO = :CODIGO_PEDIDO'
      );
      DM.FDQuery.ParamByName('CODIGO_PEDIDO').AsInteger := Pedido.Codigo;
      DM.FDQuery.Open;
      if DM.FDQuery.RecordCount > 0 then
      begin
        DM.FDQuery.First;
        while not (DM.FDQuery.Eof) do
        begin
          DataSet.Append;
          DataSet.FieldByName('Codigo').AsInteger :=
            DM.FDQuery.FieldByName('CODIGO').AsInteger;
          DataSet.FieldByName('Descricao').AsString :=
            DM.FDQuery.FieldByName('DESCRICAO').AsString;
          DataSet.FieldByName('Quantidade').AsFloat :=
            DM.FDQuery.FieldByName('QUANTIDADE').AsFloat;
          DataSet.FieldByName('ValorUnit').AsFloat :=
            DM.FDQuery.FieldByName('VALOR_UNIT').AsFloat;
          DataSet.FieldByName('ValorTotal').AsFloat :=
            DM.FDQuery.FieldByName('VALOR_TOTAL').AsFloat;
          DM.FDQuery.Next;
        end;
      end;
    end
    else
      raise Exception.Create('Pedido n?o encontrado!');
  finally
    FItensPedido.DisposeOf;
  end;
end;

constructor TDaoPedido.Create;
begin
  DM := TDM.Create(nil);
end;

procedure TDaoPedido.GravarPedido(pedido: TModelPedido);
var
  SQL: String;
  I: Integer;
begin
  DM.StartTransaction;
  try
    SQL := 'INSERT INTO PEDIDO VALUES (?,?,?,?)';
    DM.PrepareStatement(SQL);
    DM.SetValue(0, pedido.Codigo);
    DM.SetValue(1, pedido.DataEmissao);
    DM.SetValue(2, pedido.CodigoCliente);
    DM.SetValue(3, pedido.Total);
    DM.ExecSQL;
    SQL := '';

    for I := 0 to Pred(pedido.ItensPedido.Count) do
    begin
      SQL := 'INSERT INTO PEDIDO_DETALHE (CODIGO_PEDIDO, CODIGO_PRODUTO, '+
        'QUANTIDADE, VALOR_UNIT, VALOR_TOTAL) VALUES (?,?,?,?,?)';
      DM.PrepareStatement(SQL);
      DM.SetValue(0, pedido.itensPedido[I].CodigoPedido);
      DM.SetValue(1, pedido.itensPedido[I].CodigoProduto);
      DM.SetValue(2, pedido.itensPedido[I].Quantidade);
      DM.SetValue(3, pedido.itensPedido[I].ValorUnit);
      DM.SetValue(4, pedido.itensPedido[I].ValorTotal);
      DM.ExecSQL
    end;
    DM.Commit;
  except
    DM.RollBack;
  end;
end;

destructor TDaoPedido.Destroy;
begin
  DM.DisposeOf;
  inherited;
end;

procedure TDaoPedido.ExcluirPedido(codigo: Integer);
var
  SQL: String;
begin
  DM.StartTransaction;
  try
    SQL := 'DELETE FROM PEDIDO_DETALHE WHERE CODIGO_PEDIDO = ?';
    DM.PrepareStatement(SQL);
    DM.SetValue(0, codigo);
    DM.ExecSQL;
    SQL := '';
    SQL := 'DELETE FROM PEDIDO WHERE CODIGO = ?';
    DM.PrepareStatement(SQL);
    DM.SetValue(0, codigo);
    DM.ExecSQL;
    DM.Commit;
  except
    DM.RollBack;
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
    raise Exception.Create('Erro ao buscar c?d. Pedido.');
  end;
end;

end.
