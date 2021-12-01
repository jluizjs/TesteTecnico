unit WK_TesteTecnico.Model.ItensPedido;

interface

type
  TModelItensPedido = class
    private
    FCodigoPedido: Integer;
    FCodigoProduto: Integer;
    FQuantidade: Double;
    FValorUnit: Double;
    FValorTotal: Double;
    public
      constructor Create;
      destructor Destroy; override;
      property CodigoPedido:  Integer read FCodigoPedido write FCodigoPedido;
      property CodigoProduto: Integer read fCodigoProduto write fCodigoProduto;
      property Quantidade: Double read FQuantidade write FQuantidade;
      property ValorUnit:  Double read FValorUnit write FValorUnit;
      property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

implementation

{ TModelItensPedido }

constructor TModelItensPedido.Create;
begin

end;

destructor TModelItensPedido.Destroy;
begin

  inherited;
end;

end.
