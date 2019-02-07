object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 689
  Width = 594
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 530
    Top = 16
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 530
    Top = 64
  end
  object SignUpQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO TB_BIZ (BIZ_NUM, PW, NAME, ADDR) '
      'VALUES (:BIZ_NUM, :PW, :NAME, :ADDR);'
      ''
      ''
      ''
      '')
    Left = 128
    Top = 16
    ParamData = <
      item
        Name = 'BIZ_NUM'
        DataType = ftString
        ParamType = ptInput
        Size = 12
        Value = Null
      end
      item
        Name = 'PW'
        DataType = ftString
        ParamType = ptInput
        Size = 30
      end
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Size = 20
      end
      item
        Name = 'ADDR'
        DataType = ftString
        ParamType = ptInput
        Size = 100
      end>
  end
  object DupChkQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT COUNT(BIZ_CODE) AS DUPCNT FROM TB_BIZ'
      'WHERE BIZ_NUM = :BIZ_NUM')
    Left = 384
    Top = 16
    ParamData = <
      item
        Name = 'BIZ_NUM'
        DataType = ftString
        ParamType = ptInput
        Size = 12
        Value = Null
      end>
  end
  object SignUpQuery2: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO TB_BIZ_INFO (BIZ_CODE) '
      'VALUES (GEN_ID(BIZ_CODE_GEN, 0));')
    Left = 208
    Top = 16
  end
  object SignInQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT BIZ_CODE FROM TB_BIZ'
      'WHERE BIZ_NUM = :BIZ_NUM AND PW = :PW')
    Left = 128
    Top = 88
    ParamData = <
      item
        Name = 'BIZ_NUM'
        DataType = ftString
        ParamType = ptInput
        Size = 12
        Value = Null
      end
      item
        Name = 'PW'
        DataType = ftString
        ParamType = ptInput
        Size = 30
        Value = Null
      end>
  end
  object BizInfoQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM TB_BIZ_INFO'
      'WHERE BIZ_CODE = :BIZ_CODE')
    Left = 128
    Top = 160
    ParamData = <
      item
        Name = 'BIZ_CODE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object SignInQueryProvider: TDataSetProvider
    DataSet = SignInQuery
    Left = 208
    Top = 88
  end
  object BizInfoQueryProvider: TDataSetProvider
    DataSet = BizInfoQuery
    Left = 208
    Top = 160
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'CharacterSet=UTF8'
      'ConnectionDef=Coffee')
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object NotifyQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM TB_NOTIFY'
      'WHERE BIZ_CODE = :BIZ_CODE'
      'ORDER BY REG_DATE DESC')
    Left = 128
    Top = 232
    ParamData = <
      item
        Name = 'BIZ_CODE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object NotifyQueryProvider: TDataSetProvider
    DataSet = NotifyQuery
    Left = 208
    Top = 232
  end
  object NotifyInsQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO TB_NOTIFY (BIZ_CODE, CONTENT) '
      'VALUES (:BIZ_CODE, :CONTENT);'
      ''
      ''
      '')
    Left = 304
    Top = 232
    ParamData = <
      item
        Name = 'BIZ_CODE'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CONTENT'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object SalesQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM TB_SALES'
      'WHERE BIZ_CODE = :BIZ_CODE')
    Left = 128
    Top = 304
    ParamData = <
      item
        Name = 'BIZ_CODE'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object SignUpQuery3: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO TB_SALES (BIZ_CODE, COUPON) '
      'VALUES (GEN_ID(BIZ_CODE_GEN, 0), 0);')
    Left = 288
    Top = 16
  end
  object SalesQueryProvider: TDataSetProvider
    DataSet = SalesQuery
    Left = 208
    Top = 304
  end
  object SignUpClientQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'INSERT INTO TB_USER (USR_MAIL, PW) '
      'VALUES (:USR_MAIL, :PW);'
      ''
      ''
      ''
      '')
    Left = 128
    Top = 408
    ParamData = <
      item
        Name = 'USR_MAIL'
        ParamType = ptInput
      end
      item
        Name = 'PW'
        ParamType = ptInput
      end>
  end
  object SignInClientQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT USR_CODE FROM TB_USER'
      'WHERE USR_MAIL = :USR_MAIL AND PW = :PW')
    Left = 208
    Top = 408
    ParamData = <
      item
        Name = 'USR_MAIL'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PW'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
