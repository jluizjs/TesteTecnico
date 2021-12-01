unit WK_TesteTecnico.Controller.Cliente;

interface

uses
  WK_TesteTecnico.Controller.Interfaces,
  WK_TesteTecnico.Model.Cliente;

type
  TControllerCliente = class(TInterfacedObject, iControllerCliente)
    private
      FCliente : TModelCliente;
    public
      constructor Create;
      Destructor Destroy; override;
      function BuscarCliente(Value: Integer): String;
  end;

implementation

{ TControllerCliente }

function TControllerCliente.BuscarCliente(Value: Integer): String;
begin
  FCliente := TModelCliente.Create;
  try
    Result := FCliente.BuscarCliente(Value);
  finally
    FCliente.DisposeOf;
  end;
end;

constructor TControllerCliente.Create;
begin

end;

destructor TControllerCliente.Destroy;
begin

  inherited;
end;

end.
