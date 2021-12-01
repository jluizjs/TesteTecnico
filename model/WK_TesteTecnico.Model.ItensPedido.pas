unit WK_TesteTecnico.Model.ItensPedido;

interface

type
  TModelItensPedido = class
    private
    FCodigo: Integer;
    FCodigoPedido: Integer;
    FQuantidade: Double;
    FValorUnitProduto: Double;
    FValorTotal: Double;
    public
      property CodigoPedido:  Integer read FCodigo write FCodigo;
      property CodigoProduto: Integer read FCodigoPedido write FCodigoPedido;
      property QuantidadeProduto: Double read FQuantidade write FQuantidade;
      property ValorUnitProduto:  Double read FValorUnitProduto write FValorUnitProduto;
      property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

implementation

end.