unit WK_TesteTecnico.Controller.Produto;

interface

uses
  WK_TesteTecnico.Controller.Interfaces,
  WK_TesteTecnico.Model.Produto;

type
  TControllerProduto = class(TInterfacedObject, IControllerProduto)
    private
      FModelProduto : TModelProduto;
    public
      constructor Create();
      Destructor Destroy; override;
      function BuscarProduto(Value: Integer): TModelProduto;
  end;

implementation

{ TControllerProduto }

function TControllerProduto.BuscarProduto(Value: Integer): TModelProduto;
begin
  FModelProduto := TModelProduto.Create;
  try
    Result := FModelProduto.BuscarProduto(Value);
  finally
    FModelProduto.DisposeOf;
  end;
end;

constructor TControllerProduto.Create;
begin

end;

destructor TControllerProduto.Destroy;
begin

  inherited;
end;

end.
