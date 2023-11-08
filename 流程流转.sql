--*发起设计上传
declare @ScoresId int;
declare @idx as INT;
declare @UserList as NVARCHAR(100);

INSERT [dbo].[WorkInstances] ([WorkID], [WorkStep], [WorkStepID]) 
VALUES ( N'1', N'发起设计上传', N'1');
set @ScoresId = scope_identity(); 
UPDATE T_HN_Main SET WorkInstancesID = @ScoresId WHERE autoid = {autoid};

SET @UserList = {UnitCode}
/*--循环执行添加操作*/
While Len(@UserList) > 0
Begin
Set @idx = Charindex(',', @UserList);
/*--只有一条数据*/
If @idx = 0 and Len(@UserList) > 0
Begin
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID, FromApprover,Approver, ApproveStatus) 
VALUES (@ScoresId,N'1',{AccountCode}, @UserList, N'0');
Break;
End
/*--多条数据*/
If @idx > 1
Begin
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID,FromApprover, Approver, ApproveStatus) 
VALUES (@ScoresId, N'1',{AccountCode},left(@UserList, @idx - 1), N'0');
Set @UserList = right(@UserList, Len(@UserList) - @idx);
End
Else
Set @UserList = right(@UserList, Len(@UserList) - @idx);
END

--*获取勘察设计暂存项目
--declare @WorkStepID int;
--SET @WorkStepID = (SELECT TOP 1 ID FROM WorkSteps WHERE PreStepID = 0 AND WorkID = 1)
SELECT DISTINCT  a.autoid,a.ProjCode ,a.ProjName,a.ProcessingStage ,a.ProjStatus ,a.BusinessType ,a.EngineeringCategories ,a.EngineeringType,a.WorkInstancesID ,a.CreateOn 
FROM T_HN_Main a 
INNER join WorkInstances b on a.WorkInstancesID = b.ID
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = {AccountCode}   AND c.ApproveStatus = 0
order by CreateOn desc


--*设置项目经理
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*向步骤用户表添加数据*/
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID},@NextStepID,{AccountCode}, {ProjManagerID}, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode}
/*具体的业务操作*/
INSERT INTO T_HN_ProjectManager   ( ProjName   ,ProjCode   ,DesignContent   ,ProjManagerID )     
VALUES   (   {ProjName}   ,{ProjCode}   ,{DesignContent}   ,{ProjManagerID}    ); 



---获取待办项目
declare @WorkStepID int;
SET @WorkStepID = (SELECT TOP 1 ID FROM WorkSteps WHERE PreStepID = 0 AND WorkID = 1)
SELECT DISTINCT  a.autoid,a.ProjCode ,a.ProjName,d.Step AS ProcessingStage ,a.ProjStatus ,a.BusinessType ,a.EngineeringCategories ,a.EngineeringType  ,a.WorkInstancesID,a.CreateOn 
FROM T_HN_Main a 
INNER join WorkInstances b on a.WorkInstancesID = b.ID
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
INNER JOIN WorkSteps d ON b.WorkStepID = d.ID
WHERE c.Approver = {AccountCode}   AND c.ApproveStatus = 0
order by CreateOn DESC



--*任务分配(二)

DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID  
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID}  
/*向步骤用户表添加数据*/
declare @idx as INT;
declare @UserList as NVARCHAR(100);

SET @UserList = {UserID}
/*--循环执行添加操作*/
While Len(@UserList) > 0
Begin
Set @idx = Charindex(',', @UserList);
/*--只有一条数据*/
If @idx = 0 and Len(@UserList) > 0
Begin
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID, FromApprover,Approver, ApproveStatus) 
VALUES ({WorkInstancesID},@NextStepID,{AccountCode}, @UserList, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} AND WorkStepID = @WorkStepID
Break;
End
/*--多条数据*/
If @idx > 1
Begin
INSERT [dbo].[StepApprovers] (WorkInsID, WorkStepID, FromApprover,Approver, ApproveStatus) 
VALUES ({WorkInstancesID}, @NextStepID,{AccountCode},left(@UserList, @idx - 1), N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} AND WorkStepID = @WorkStepID
Set @UserList = right(@UserList, Len(@UserList) - @idx);
End
Else
Set @UserList = right(@UserList, Len(@UserList) - @idx);
END

--更新政策性审查
--UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}

--更新技术性审查人员
UPDATE  [StepApprovers] SET ApproveStatus = -1 WHERE WorkInsID = {WorkInstancesID} AND Approver IN ({UserID})


--*图纸上传操作  
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*向步骤用户表添加数据*/
INSERT [dbo].[StepApprovers] (WorkInsID, WorkStepID, FromApprover,Approver, ApproveStatus) 
VALUES ({WorkInstancesID}, @NextStepID,{AccountCode}, dbo.func_hn_getFromApprover( {WorkInstancesID},{UserID}), N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}  AND WorkStepID = @WorkStepID



--*勘察设计经理通过
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID}  

declare @idx as INT;
declare @UserList as NVARCHAR(100);

SET @UserList = {UnitCode}
/*--循环执行添加操作*/
While Len(@UserList) > 0
Begin
Set @idx = Charindex(',', @UserList);
/*--只有一条数据*/
If @idx = 0 and Len(@UserList) > 0
Begin
INSERT [dbo].[StepApprovers] (WorkInsID, WorkStepID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID},@NextStepID,{AccountCode}, @UserList, N'0');= @WorkStepID
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} AND WorkStepID = @WorkStepID
Break;
End
/*--多条数据*/
If @idx > 1
Begin
INSERT [dbo].[StepApprovers] (WorkInsID, WorkStepID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID},@NextStepID,{AccountCode},  left(@UserList, @idx - 1), N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} AND WorkStepID = @WorkStepID
Set @UserList = right(@UserList, Len(@UserList) - @idx);
End
Else
Set @UserList = right(@UserList, Len(@UserList) - @idx);
END



--获取审查单位暂存项目
SELECT a.autoid,a.ProjCode ,a.ProjName,a.ProcessingStage ,a.ProjStatus ,a.BusinessType ,a.EngineeringCategories ,a.EngineeringType
FROM T_HN_Main a 
INNER join T_HN_Main_CensorshipInfo b on a.autoid = b.mainid 
INNER join WorkInstances c on a.WorkInstancesID = c.ID
WHERE b.CI_AccountCode = {AccountCode} and a.RoleType in ('3') and c.WorkStepsID = 5 AND b.CI_IsSetManager = 0 order by CreateOn desc



--（审图机构）政策性审查 
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*向步骤用户表添加数据*/
INSERT [dbo].[StepApprovers] (WorkInsID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID}, {AccountCode},{UserID}, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}
UPDATE  [StepApprovers] SET ApproveStatus = 0 WHERE WorkInsID = {WorkInstancesID} AND ApproveStatus = -1

--（审图机构）技术性审查 
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*向步骤用户表添加数据*/
INSERT [dbo].[StepApprovers] (WorkInsID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID}, {AccountCode},{UserID}, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}  


--（审图机构）项目经理核准项目 
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*向步骤用户表添加数据*/
INSERT [dbo].[StepApprovers] (WorkInsID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID}, {AccountCode},{UserID}, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}

/*自定义的一些代码Begin*/
CREATE FUNCTION dbo.func_hn_getFromApprover(@WorkInstancesID varchar(8),@UserID varchar(50)) 
--CREATE FUNCTION 函数名称（@参数名 参数的数据类型）
RETURNS varchar(20)   --返回返回值的数据类型
--[WITH ENCRYPTION]  --如果指定了 encryption 则函数被加密
as
BEGIN
    declare @result_name varchar(20)
	SELECT  @result_name = FromApprover FROM  StepApprovers  WHERE WorkInsID = @WorkInstancesID AND Approver = @UserID  
  RETURN  @result_name
END
/*自定义的一些代码END*/ 