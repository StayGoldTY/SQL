GO
alter table T_HN_DesignEnterpriseInfo_QLevel add EQ_Industry varchar(50)
GO
alter table T_HN_DesignEnterpriseInfo_QLevel add EQ_CertificateName varchar(50)
GO
CREATE TABLE [dbo].[T_HN_ReviewEnterpriseInfo_QLevel](
	[ID] [nvarchar](32) NOT NULL,
	[username] [nvarchar](100) NULL,
	[orgcode] [nvarchar](200) NULL,
	[mainid] [nvarchar](32) NOT NULL,
	[maintbl] [nvarchar](200) NULL,
	[subodr] [int] NULL,
	[EQ_QualificationCategory] [nvarchar](100) NULL,
	[EQ_QualificationType] [nvarchar](100) NULL,
	[EQ_QualificationLevel] [nvarchar](100) NULL,
	[EQ_CertificateNo] [nvarchar](100) NULL,
	[EQ_ValidUntil] [nvarchar](100) NULL,
	[EQ_Attachment] [nvarchar](100) NULL,
	[CREATETIME] [datetime] NULL,
	[UPDATEBY] [nvarchar](64) NULL,
	[UPDATETIME] [datetime] NULL,
	[ISACTIVE] [bit] NULL,
	[CREATEBY] [nvarchar](64) NULL,
	[EQ_AttachmentID] [varchar](128) NULL,
	[EQ_Industry] [varchar](50) NULL,
	[EQ_CertificateName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

