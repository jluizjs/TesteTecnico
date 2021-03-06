unit WK_TesteTecnico.Controller.Interfaces;

interface

uses
  WK_TesteTecnico.Model.Produto,
  WK_TesteTecnico.Model.Pedido;

type

  IControllerPedido = interface
    ['{E6EFD0F3-F0DB-476A-AAC5-27911AAC8F26}']
    function NovoPedido(): Integer;
    procedure GravarPedido(Pedido: TModelPedido);
  end;

  IControllerProduto = interface
    ['{30D23A47-259F-4C17-B954-0657C38B19EC}']
    function BuscarProduto(Value: Integer): TModelProduto;
  end;

  IControllerCliente = interface
    ['{C8679822-40FE-4929-B13E-475506E23533}']
    function BuscarCliente(Value: Integer): String;
  end;

implementation

end.
