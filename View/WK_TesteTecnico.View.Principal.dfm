object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'WK Teste Tecnico - Pedido'
  ClientHeight = 437
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 742
    Height = 437
    Align = alClient
    TabOrder = 0
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 740
      Height = 88
      Align = alTop
      TabOrder = 0
      object lblNomeCliente: TLabel
        Left = 157
        Top = 5
        Width = 54
        Height = 19
        Caption = 'Cliente:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblCliente: TLabel
        Left = 10
        Top = 5
        Width = 56
        Height = 19
        Caption = 'C'#243'digo:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblCodigoCliente: TLabel
        Left = 72
        Top = 5
        Width = 5
        Height = 19
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object pnlCodigoPedido: TPanel
        Left = 556
        Top = 1
        Width = 183
        Height = 30
        Align = alRight
        TabOrder = 0
        object lblPedido: TLabel
          Left = 8
          Top = -1
          Width = 101
          Height = 25
          Caption = 'N'#186' Pedido:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lblCodigoPedido: TLabel
          Left = 175
          Top = 1
          Width = 7
          Height = 28
          Align = alRight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitHeight = 25
        end
      end
      object pnlProduto: TPanel
        Left = 1
        Top = 31
        Width = 738
        Height = 56
        Align = alBottom
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lblProduto: TLabel
          Left = 56
          Top = 1
          Width = 44
          Height = 16
          Caption = 'Produto'
        end
        object edtValorUnitProduto: TLabeledEdit
          Left = 415
          Top = 20
          Width = 75
          Height = 24
          EditLabel.Width = 60
          EditLabel.Height = 16
          EditLabel.Caption = 'Valor Unit.'
          TabOrder = 3
          OnKeyPress = edtValorUnitProdutoKeyPress
        end
        object btnInserirItem: TButton
          Left = 554
          Top = 1
          Width = 183
          Height = 54
          Align = alRight
          Caption = 'Inserir Item'
          TabOrder = 4
          OnClick = btnInserirItemClick
        end
        object edtQuantidadeProduto: TLabeledEdit
          Left = 334
          Top = 20
          Width = 59
          Height = 24
          EditLabel.Width = 65
          EditLabel.Height = 16
          EditLabel.Caption = 'Quantidade'
          TabOrder = 2
          Text = '1'
          OnKeyPress = edtQuantidadeProdutoKeyPress
        end
        object edtDescricaoProduto: TEdit
          Left = 55
          Top = 20
          Width = 273
          Height = 24
          TabOrder = 1
        end
        object edtCodigoProduto: TLabeledEdit
          Left = 9
          Top = 20
          Width = 41
          Height = 24
          EditLabel.Width = 26
          EditLabel.Height = 16
          EditLabel.Caption = 'C'#243'd.'
          TabOrder = 0
          OnKeyPress = edtCodigoProdutoKeyPress
        end
      end
    end
    object pnlBottom: TPanel
      Left = 1
      Top = 400
      Width = 740
      Height = 36
      Align = alBottom
      TabOrder = 1
      object Label2: TLabel
        Left = 1
        Top = 1
        Width = 123
        Height = 34
        Align = alLeft
        Alignment = taCenter
        Caption = 'Total Pedido:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ExplicitHeight = 25
      end
      object lblTotalPedido: TLabel
        Left = 136
        Top = 1
        Width = 7
        Height = 25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
    end
    object pnlMenu: TPanel
      Left = 556
      Top = 89
      Width = 185
      Height = 311
      Align = alRight
      TabOrder = 2
      object btnGravarPedido: TButton
        Left = 1
        Top = 51
        Width = 183
        Height = 25
        Align = alTop
        Caption = 'Gravar Pedido'
        Enabled = False
        TabOrder = 0
        OnClick = btnGravarPedidoClick
        ExplicitTop = 26
      end
      object btnBuscarPedido: TButton
        Left = 1
        Top = 76
        Width = 183
        Height = 25
        Align = alTop
        Caption = 'Buscar Pedido'
        TabOrder = 1
        OnClick = btnBuscarPedidoClick
        ExplicitTop = 51
      end
      object btnExcluirPedido: TButton
        Left = 1
        Top = 101
        Width = 183
        Height = 25
        Align = alTop
        Caption = 'Excluir Pedido'
        TabOrder = 2
        OnClick = btnExcluirPedidoClick
        ExplicitTop = 76
      end
      object btnSair: TButton
        Left = 1
        Top = 285
        Width = 183
        Height = 25
        Align = alBottom
        Caption = 'Sair'
        TabOrder = 3
        OnClick = btnSairClick
      end
      object btnNovoPedido: TButton
        Left = 1
        Top = 1
        Width = 183
        Height = 25
        Align = alTop
        Caption = 'Novo Pedido'
        TabOrder = 4
        OnClick = btnNovoPedidoClick
      end
      object btnCancelarPedido: TButton
        Left = 1
        Top = 26
        Width = 183
        Height = 25
        Align = alTop
        Caption = 'Cancelar Pedido'
        Enabled = False
        TabOrder = 5
        OnClick = btnCancelarPedidoClick
        ExplicitTop = 20
      end
    end
    object TPanel
      Left = 1
      Top = 89
      Width = 555
      Height = 311
      Align = alClient
      TabOrder = 3
      object dbgDetPedido: TDBGrid
        Left = 1
        Top = 1
        Width = 553
        Height = 309
        Align = alClient
        DataSource = dsDetPedido
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyPress = dbgDetPedidoKeyPress
        Columns = <
          item
            Expanded = False
            FieldName = 'Codigo'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Descricao'
            Title.Caption = 'Descri'#231#227'o'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorUnit'
            Title.Caption = 'Valor Unit.'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Quantidade'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorTotal'
            Title.Caption = 'Total'
            Visible = True
          end>
      end
    end
  end
  object dsDetPedido: TDataSource
    DataSet = cdsDetPedido
    Left = 22
    Top = 161
  end
  object cdsDetPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    OnCalcFields = cdsDetPedidoCalcFields
    Left = 24
    Top = 208
    object cdsDetPedidoCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsDetPedidoDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object cdsDetPedidoValorUnit: TFloatField
      FieldName = 'ValorUnit'
      DisplayFormat = '#.00'
    end
    object cdsDetPedidoQuantidade: TFloatField
      FieldName = 'Quantidade'
      DisplayFormat = '#.000'
      currency = True
    end
    object cdsDetPedidoValorTotal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'ValorTotal'
      DisplayFormat = '#.00'
      currency = True
      Calculated = True
    end
  end
  object dspItensPedido: TDataSetProvider
    Left = 24
    Top = 256
  end
end
