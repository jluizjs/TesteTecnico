unit WK_TesteTecnico.Model.Pedido;

interface

uses
  System.Generics.Collections,
  WK_TesteTecnico.Model.ItensPedido;

type
  TModelPedido = class
    private
      FTotal: Double;
      FDataEmissao: TDateTime;
      FCodigoCliente: Integer;
      FCodigo: Integer;
      FItensPedido: TList<TModelItensPedido>;
    public
      constructor Create;
      destructor Destroy; override;
      property Codigo: Integer read FCodigo write FCodigo;
      property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
      property CodigoCliente: Integer read FCodigoCliente write FCodigoCliente;
      property Total: Double read FTotal write FTotal;
      property ItensPedido: TList<TModelItensPedido> read FitensPedido write FitensPedido;
  end;

implementation

uses
  WK_TesteTecnico.Model.Produto, System.SysUtils;

{ TModelPedido }

constructor TModelPedido.Create;
begin
  FitensPedido := TList<TModelItensPedido>.Create;
end;

destructor TModelPedido.Destroy;
begin
  FitensPedido.DisposeOf;
  inherited;
end;

end.
