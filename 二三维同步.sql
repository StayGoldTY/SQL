
CREATE TABLE [dbo].[BIM_RunningRecord](
	[ID] [varchar](50) NOT NULL,
	[ProjectId] [varchar](50) NOT NULL,
	[StepName] [varchar](50) NULL,
	[Status] [smallint] NULL,
	[Action] [varchar](50) NULL,
	[SubmitBy] [nvarchar](50) NULL,
	[SubmitTime] [datetime] NULL,
	[Comments] [nvarchar](200) NULL,
	[CREATEBY] [nvarchar](50) NULL,
	[CREATETIME] [datetime] NULL,
	[UPDATEBY] [nvarchar](50) NULL,
	[UPDATETIME] [datetime] NULL,
	[ISACTIVE] [bit] NULL,
 
)


