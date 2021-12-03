unit WK_TesteTecnico.Model.DM;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Datasnap.DBClient,
  Datasnap.Provider;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDQuery: TFDQuery;
    cdsDetPedido: TClientDataSet;
    dspItensPedido: TDataSetProvider;
    FDMemTable1: TFDMemTable;
    cdsDetPedidoValorUnit: TFloatField;
    cdsDetPedidoQuantidade: TFloatField;
    cdsDetPedidoValorTotal: TFloatField;
    cdsDetPedidoCodigo: TIntegerField;
    cdsDetPedidoDescricao: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsDetPedidoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PrepareStatement( aSQL: String);
    procedure SetValue( aIndex: Integer; aValue: Variant);
    procedure ExecSQL;
    procedure StartTransaction;
    procedure Commit;
    procedure RollBack;

  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.cdsDetPedidoCalcFields(DataSet: TDataSet);
begin
  cdsDetPedido.FieldByName('ValorTotal').AsFloat :=
    cdsDetPedido.FieldByName('ValorUnit').AsFloat*
    cdsDetPedido.FieldByName('Quantidade').AsFloat;
end;

procedure TDM.Commit;
begin
  FDConnection.Commit;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  cdsDetPedido.CreateDataSet;
  cdsDetPedido.Active := True;
  FDConnection.Connected := False;
  FDConnection.Params.Add('DriverID=MYSQL');
  FDConnection.Params.Add('Database=wk_testetecnico');
  FDConnection.Params.Add('User_name=root');
  FDConnection.Params.Add('Password=MySQLroot@123');
  FDConnection.Params.Add('Server=localhost');
  FDConnection.Params.Add('Port=3306');
  FDConnection.Connected := True;
end;

procedure TDM.ExecSQL;
begin
  FDQuery.ExecSQL;
end;

procedure TDM.PrepareStatement(aSQL: String);
begin
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(aSQL);
end;

procedure TDM.RollBack;
begin
  FDConnection.Rollback;
end;

procedure TDM.SetValue(aIndex: Integer; aValue: Variant);
begin
  FDQuery.Params.Add;
  FDQuery.Params[aIndex].Value := aValue;
end;

procedure TDM.StartTransaction;
begin
  FDConnection.StartTransaction;
end;

end.
