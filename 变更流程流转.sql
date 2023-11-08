--*发起设计上传 *
declare @EditType NVARCHAR(10);
declare @ScoresId1 int;declare @ScoresId2 int;
declare @idx as INT; declare @Number as INT;declare @UserList as NVARCHAR(100);  

SELECT @EditType = a.SE_EditForm FROM T_HN_Main_SurveyDesignEdit a WHERE a.mainid =(
 SELECT TOP 1 b.autoid FROM dbo.T_HN_Main b WHERE b.autoid = {autoid})

INSERT INTO T_HN_EditTask (username,MainID ,IsConfirm)VALUES ({AccountCode} ,{autoid} ,'0')

IF @EditType =1 BEGIN
	INSERT [dbo].[WorkInstances] ([WorkID], [WorkStep], [WorkStepID])  VALUES ( N'3', N'（勘察机构）填报设计变更单', N'2'); 
	SET @ScoresId1 = scope_identity(); 
END
IF @EditType =2 BEGIN
	INSERT [dbo].[WorkInstances] ([WorkID], [WorkStep], [WorkStepID])  VALUES ( N'2', N'（勘察机构）设定项目经理', N'2'); 
	SET @ScoresId1 = scope_identity(); 
END
SET @UserList = {UnitCode};
SET @Number = Charindex(',', @UserList);
If @Number > 1 Begin 
	IF @EditType =1 BEGIN
	INSERT [dbo].[WorkInstances] ([WorkID], [WorkStep], [WorkStepID])  VALUES ( N'3', N'（勘察机构）填报设计变更单', N'2'); 
	SET @ScoresId2 = scope_identity();  
	END
	IF @EditType =2 BEGIN
	INSERT [dbo].[WorkInstances] ([WorkID], [WorkStep], [WorkStepID])  VALUES ( N'2', N'（勘察机构）设定项目经理', N'2'); 
	SET @ScoresId2 = scope_identity(); 
	END
	UPDATE T_HN_Main SET WorkInstancesID = CAST(@ScoresId1 AS VARCHAR(10)) + ',' + CAST(@ScoresId2 AS VARCHAR(10)) WHERE autoid = {autoid}; 
	UPDATE T_HN_Main_SurveyDesignUnit SET SD_WorkInstancesID = @ScoresId1 WHERE mainid = {autoid} AND SD_DesignContent = '1';
	UPDATE T_HN_Main_SurveyDesignUnit SET SD_WorkInstancesID = @ScoresId2 WHERE mainid = {autoid} AND SD_DesignContent = '2';

	UPDATE T_HN_Main_CensorshipInfo SET CI_WorkInstancesID = @ScoresId1 WHERE mainid = {autoid} AND CI_ReviewContent = '1';
	UPDATE T_HN_Main_CensorshipInfo SET CI_WorkInstancesID = @ScoresId2 WHERE mainid = {autoid} AND CI_ReviewContent = '2';
END
	
ELSE
begin
	UPDATE T_HN_Main SET WorkInstancesID = @ScoresId1 WHERE autoid = {autoid}; 
	UPDATE T_HN_Main_SurveyDesignUnit SET SD_WorkInstancesID = @ScoresId1 WHERE mainid = {autoid} ;

	UPDATE T_HN_Main_CensorshipInfo SET CI_WorkInstancesID = @ScoresId1 WHERE mainid = {autoid} ;
	SET @ScoresId2 = @ScoresId1; 
end

 /*--循环执行添加操作*/ 
WHILE Len(@UserList) > 0
BEGIN
Set @idx = Charindex(',', @UserList);  
/*--只有一条数据*/
If @idx = 0 and Len(@UserList) > 0 Begin INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID, FromApprover,Approver, ApproveStatus)  VALUES (@ScoresId2,N'2',{AccountCode}, @UserList, N'0');
 Break; End 
/*--多条数据*/
If @idx > 1 Begin 
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID,FromApprover, Approver, ApproveStatus)  VALUES (@ScoresId1, N'2',{AccountCode},left(@UserList, @idx - 1), N'0'); 

SET @UserList = right(@UserList, Len(@UserList) - @idx); End 
Else 
SET @UserList = right(@UserList, Len(@UserList) - @idx); END


--*获取未确认台账 
SELECT DISTINCT a.autoid,a.GGProjCode ,a.ProjCode ,a.ProjName,  isnull(b.WorkStep,'建设单位新建变更') as ProcessingStage,a.ProjStatus ,a.BusinessType ,a.EngineeringCategories ,a.EngineeringType,b.ID as WorkInstancesID ,a.CreateOn  
FROM WorkInstances b
left join T_HN_Main a on   charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
LEFT JOIN T_HN_EditTask d ON a.autoid = d.MainID
left JOIN StepApprovers c ON c.WorkInsID = b.ID 
WHERE c.Approver = {AccountCode}   AND c.ApproveStatus = 0 AND d.IsConfirm = '0' order by CreateOn DESC


--*获取已确认台账 
SELECT DISTINCT a.autoid,a.GGProjCode ,a.ProjCode ,a.ProjName,  isnull(b.WorkStep,'建设单位新建变更') as ProcessingStage,a.ProjStatus ,a.BusinessType ,a.EngineeringCategories ,a.EngineeringType,b.ID as WorkInstancesID ,a.CreateOn  
FROM WorkInstances b
left join T_HN_Main a on   charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
LEFT JOIN T_HN_EditTask d ON a.autoid = d.MainID
left JOIN StepApprovers c ON c.WorkInsID = b.ID 
WHERE c.Approver = {AccountCode}   AND c.ApproveStatus = 0 AND d.IsConfirm = '1' order by CreateOn DESC

--点击确认查看按钮
UPDATE T_HN_EditTask SET IsConfirm = '1' WHERE MainID = {autoid}

--勘察确认变更单
DECLARE @WorkID    NVARCHAR(20); DECLARE @WorkStepID    NVARCHAR(20); DECLARE @NextStepID    NVARCHAR(20); DECLARE @NextStep  nvarchar(20);  
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID};  
SELECT @NextStepID = NextStepID,@NextStep = NextStep  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID  
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*向步骤用户表添加数据*/
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID,FromApprover, Approver, ApproveStatus)  VALUES ({WorkInstancesID},@NextStepID,{AccountCode},dbo.func_hn_getFromApprover( {WorkInstancesID},{AccountCode}), N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} 


--建设确认变更单

DECLARE @WorkID    NVARCHAR(20); DECLARE @WorkStepID    NVARCHAR(20); DECLARE @NextStepID    NVARCHAR(20); DECLARE @NextStep  nvarchar(20);  
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID};  
SELECT @NextStepID = NextStepID,@NextStep = NextStep  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID  
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*向步骤用户表添加数据*/

UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} 

IF @WorkID = '3'
Begin
update T_HN_Main set ProjStatus = 2 where  WorkInstancesID = {WorkInstancesID};
END

--建设统一确认

DECLARE @WorkID    NVARCHAR(20); DECLARE @WorkStepID    NVARCHAR(20);  DECLARE @NextStepID    NVARCHAR(20); DECLARE @NextStep  nvarchar(20);  
 SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID};   SELECT @NextStepID = NextStepID,@NextStep = NextStep  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID   Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID}  IF @WorkID = '3' BEGIN  /*向步骤用户表添加数据*/ UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode}   update T_HN_Main set ProjStatus = 2 where  WorkInstancesID = {WorkInstancesID}; END  IF @WorkID = '2' Begin   DECLARE @idx as INT; declare @UserList as NVARCHAR(100);  SET @UserList = {UnitCode}    /*--循环执行添加操作*/    WHILE Len(@UserList) > 0    BEGIN Set @idx = Charindex(',', @UserList);    /*--只有一条数据*/    IF @idx = 0 and Len(@UserList) > 0    BEGIN    INSERT [dbo].[StepApprovers] (WorkInsID, WorkStepID,FromApprover, Approver, ApproveStatus)  VALUES ({WorkInstancesID},@NextStepID,{AccountCode}, @UserList, N'0');    UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} AND WorkStepID = @WorkStepID Break; End    /*--多条数据*/    IF @idx > 1 Begin INSERT [dbo].[StepApprovers] (WorkInsID, WorkStepID,FromApprover, Approver, ApproveStatus)  VALUES ({WorkInstancesID},@NextStepID,{AccountCode},  left(@UserList, @idx - 1), N'0');    UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} AND WorkStepID = @WorkStepID  
  SET @UserList = right(@UserList, Len(@UserList) - @idx); End Else Set @UserList = right(@UserList, Len(@UserList) - @idx); END END
