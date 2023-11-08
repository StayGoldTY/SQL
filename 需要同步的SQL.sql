USE [hnstdb_test]
--update T_HN_FileList set autoid = autoid + 1
GO
INSERT INTO [dbo].[T_HN_FileList]
           ([autoid]
           ,[FileListType]
           ,[ID]
           ,[Label]
           ,[ParentID]
           ,[MajorID]
           ,[ISNeedPicNum])
     VALUES
           (1
           ,'1'
           ,'0.5'
           ,'导入文件'
           ,'0'
           ,null
           ,null)
GO


