unit WK_TesteTecnico.Model.Produto;

interface

uses
  WK_TesteTecnico.Model.Interfaces;
type
  TModelProduto = class
    private
      FDescricao: String;
      FPrecoVenda: Double;
      FCodigo: Integer;
    public
      constructor Create();
      destructor Destroy; override;
      function BuscarProduto(value: Integer): TModelProduto;
      property Codigo: Integer read FCodigo write FCodigo;
      property Descricao: String read FDescricao write FDescricao;
      property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;
  end;

implementation

uses
  WK_TesteTecnico.Model.DM,
  System.SysUtils;

{ TModelProduto }

function TModelProduto.BuscarProduto(value: Integer): TModelProduto;
var
  produto : TModelProduto;
begin
  try
    produto := TModelProduto.Create;
    produto.FCodigo := value;
    produto.FDescricao := DM.FDConnection.ExecSQLScalar(
      'SELECT DESCRICAO FROM PRODUTO WHERE CODIGO = :CODIGO'
      ,[produto.FCodigo]);
    produto.FPrecoVenda := DM.FDConnection.ExecSQLScalar(
      'SELECT PRECO_VENDA FROM PRODUTO WHERE CODIGO = :CODIGO'
      ,[produto.FCodigo]);
    Result := produto;
  except
    raise Exception.Create('Erro ao buscar Produto.');
  end;
end;

constructor TModelProduto.Create;
begin

end;

destructor TModelProduto.Destroy;
begin

  inherited;
end;

end.
