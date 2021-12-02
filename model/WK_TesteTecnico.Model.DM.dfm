object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 301
  Width = 542
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=wk_testetecnico'
      'User_Name=root'
      'Password=MySQLroot@123'
      'Server=LOCALHOST'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 24
    Top = 64
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    Left = 224
    Top = 64
  end
  object cdsDetPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    OnCalcFields = cdsDetPedidoCalcFields
    Left = 24
    Top = 120
    object cdsDetPedidoCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsDetPedidoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object cdsDetPedidoValorUnit: TFloatField
      FieldName = 'ValorUnit'
    end
    object cdsDetPedidoQuantidade: TFloatField
      FieldName = 'Quantidade'
    end
    object cdsDetPedidoValorTotal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ValorTotal'
      Calculated = True
    end
  end
  object dspItensPedido: TDataSetProvider
    Left = 24
    Top = 168
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 224
    Top = 112
  end
end
