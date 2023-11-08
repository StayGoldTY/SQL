--drop table T_HN_CompanyMapInfo

CREATE TABLE [dbo].[T_HN_CompanyMapInfo](
	[ID] [nvarchar](32) NOT NULL,
	[CompanyName] [nvarchar](200) NULL,
	[CompanyCode] [nvarchar](100) NULL,
	[CompanyCertificateCode] [nvarchar](100) NULL
)
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海南城建业施工图审查有限公司',
		    '91460000730059768B'
           ,'琼A')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海口市城建建设工程施工图设计文件审查有限公司',
		    Null
           ,'琼B')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '三亚市建协施工图设计审查有限公司',
		    Null
           ,'琼C')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海南省设计研究院有限公司（海南省设计研究院有限公司施工图审查中心）',
		    '91460000201243842M'
           ,'琼D')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '雅克设计有限公司（雅克设计有限公司审图中心）',
		    Null
           ,'琼E')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海南泓景建筑设计有限公司（海南泓景工程设计文件审查服务中心）',
		    '914600007358446263'
           ,'琼F')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海南华磊建筑设计咨询有限公司（华磊建设工程施工图设计文件审查服务中心）',
		    Null
           ,'琼G')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海口市城市规划设计研究院有限公司（海口市城市规划设计研究院有限公司施工图审查中心）',
		    Null
           ,'琼H')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海南华筑国际工程设计咨询管理有限公司（海南华筑图审中心）',
		    Null
           ,'琼I')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海口市市政工程设计研究院（海口市市政工程设计研究院图审中心）',
		    Null
           ,'琼J')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海南元正建筑设计咨询有限责任公司施工图审查服务中心',
		    Null
           ,'琼J')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '海南佳风工程设计有限公司（海南佳风市政基础设施工程施工图审查中心）',
		    Null
           ,'琼K')
GO