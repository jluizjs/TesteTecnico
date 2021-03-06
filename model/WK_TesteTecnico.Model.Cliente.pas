unit WK_TesteTecnico.Model.Cliente;

interface

uses
  WK_TesteTecnico.Model.Interfaces;

type
  TModelCliente = class
    private
      FCodigo: Integer;
      FNome: String;
      FCidade: String;
      FUF: String;
    public
      function BuscarCliente(Value : Integer): String;
      property cliCodigo: Integer read FCodigo write FCodigo;
      property cliNome: String read FNome write FNome;
      property cliCidade: String read FCidade write FCidade;
      property cliUF: String read FUF write FUF;
  end;

implementation

{ Cliente }

uses
  WK_TesteTecnico.Model.DM,
  System.SysUtils,
  Vcl.Dialogs;

{ TCliente }

function TModelCliente.BuscarCliente(value: Integer): String;
begin
  try
    Result := DM.FDConnection.ExecSQLScalar(
      'SELECT NOME FROM CLIENTE WHERE CODIGO = :CODIGO'
      ,[value]
    );
  Except on E: Exception do
    ShowMessage('Erro: ' + E.Message);
  end;
end;

end.
