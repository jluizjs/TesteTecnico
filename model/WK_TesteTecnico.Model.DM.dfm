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
    Left = 24
    Top = 128
  end
end
