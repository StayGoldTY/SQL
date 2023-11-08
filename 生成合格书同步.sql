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
		    '���ϳǽ�ҵʩ��ͼ������޹�˾',
		    '91460000730059768B'
           ,'��A')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '�����гǽ����蹤��ʩ��ͼ����ļ�������޹�˾',
		    Null
           ,'��B')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '�����н�Эʩ��ͼ���������޹�˾',
		    Null
           ,'��C')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '����ʡ����о�Ժ���޹�˾������ʡ����о�Ժ���޹�˾ʩ��ͼ������ģ�',
		    '91460000201243842M'
           ,'��D')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '�ſ�������޹�˾���ſ�������޹�˾��ͼ���ģ�',
		    Null
           ,'��E')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '������������������޹�˾������������������ļ����������ģ�',
		    '914600007358446263'
           ,'��F')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '���ϻ��ڽ��������ѯ���޹�˾�����ڽ��蹤��ʩ��ͼ����ļ����������ģ�',
		    Null
           ,'��G')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '�����г��й滮����о�Ժ���޹�˾�������г��й滮����о�Ժ���޹�˾ʩ��ͼ������ģ�',
		    Null
           ,'��H')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '���ϻ������ʹ��������ѯ�������޹�˾�����ϻ���ͼ�����ģ�',
		    Null
           ,'��I')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '������������������о�Ժ��������������������о�Ժͼ�����ģ�',
		    Null
           ,'��J')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '����Ԫ�����������ѯ�������ι�˾ʩ��ͼ����������',
		    Null
           ,'��J')
GO
INSERT INTO [dbo].[T_HN_CompanyMapInfo]
           ([ID]
           ,[CompanyName]
           ,[CompanyCode]
           ,[CompanyCertificateCode])
     VALUES
           (replace(lower(NEWID()),'-',''),
		    '���ϼѷ繤��������޹�˾�����ϼѷ�����������ʩ����ʩ��ͼ������ģ�',
		    Null
           ,'��K')
GO