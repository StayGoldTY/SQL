--*��������ϴ�
declare @ScoresId int;
declare @idx as INT;
declare @UserList as NVARCHAR(100);

INSERT [dbo].[WorkInstances] ([WorkID], [WorkStep], [WorkStepID]) 
VALUES ( N'1', N'��������ϴ�', N'1');
set @ScoresId = scope_identity(); 
UPDATE T_HN_Main SET WorkInstancesID = @ScoresId WHERE autoid = {autoid};

SET @UserList = {UnitCode}
/*--ѭ��ִ����Ӳ���*/
While Len(@UserList) > 0
Begin
Set @idx = Charindex(',', @UserList);
/*--ֻ��һ������*/
If @idx = 0 and Len(@UserList) > 0
Begin
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID, FromApprover,Approver, ApproveStatus) 
VALUES (@ScoresId,N'1',{AccountCode}, @UserList, N'0');
Break;
End
/*--��������*/
If @idx > 1
Begin
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID,FromApprover, Approver, ApproveStatus) 
VALUES (@ScoresId, N'1',{AccountCode},left(@UserList, @idx - 1), N'0');
Set @UserList = right(@UserList, Len(@UserList) - @idx);
End
Else
Set @UserList = right(@UserList, Len(@UserList) - @idx);
END

--*��ȡ��������ݴ���Ŀ
--declare @WorkStepID int;
--SET @WorkStepID = (SELECT TOP 1 ID FROM WorkSteps WHERE PreStepID = 0 AND WorkID = 1)
SELECT DISTINCT  a.autoid,a.ProjCode ,a.ProjName,a.ProcessingStage ,a.ProjStatus ,a.BusinessType ,a.EngineeringCategories ,a.EngineeringType,a.WorkInstancesID ,a.CreateOn 
FROM T_HN_Main a 
INNER join WorkInstances b on a.WorkInstancesID = b.ID
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = {AccountCode}   AND c.ApproveStatus = 0
order by CreateOn desc


--*������Ŀ����
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*�����û����������*/
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID},@NextStepID,{AccountCode}, {ProjManagerID}, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode}
/*�����ҵ�����*/
INSERT INTO T_HN_ProjectManager   ( ProjName   ,ProjCode   ,DesignContent   ,ProjManagerID )     
VALUES   (   {ProjName}   ,{ProjCode}   ,{DesignContent}   ,{ProjManagerID}    ); 



---��ȡ������Ŀ
declare @WorkStepID int;
SET @WorkStepID = (SELECT TOP 1 ID FROM WorkSteps WHERE PreStepID = 0 AND WorkID = 1)
SELECT DISTINCT  a.autoid,a.ProjCode ,a.ProjName,d.Step AS ProcessingStage ,a.ProjStatus ,a.BusinessType ,a.EngineeringCategories ,a.EngineeringType  ,a.WorkInstancesID,a.CreateOn 
FROM T_HN_Main a 
INNER join WorkInstances b on a.WorkInstancesID = b.ID
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
INNER JOIN WorkSteps d ON b.WorkStepID = d.ID
WHERE c.Approver = {AccountCode}   AND c.ApproveStatus = 0
order by CreateOn DESC



--*�������(��)

DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID  
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID}  
/*�����û����������*/
declare @idx as INT;
declare @UserList as NVARCHAR(100);

SET @UserList = {UserID}
/*--ѭ��ִ����Ӳ���*/
While Len(@UserList) > 0
Begin
Set @idx = Charindex(',', @UserList);
/*--ֻ��һ������*/
If @idx = 0 and Len(@UserList) > 0
Begin
INSERT [dbo].[StepApprovers] (WorkInsID,WorkStepID, FromApprover,Approver, ApproveStatus) 
VALUES ({WorkInstancesID},@NextStepID,{AccountCode}, @UserList, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} AND WorkStepID = @WorkStepID
Break;
End
/*--��������*/
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

--�������������
--UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}

--���¼����������Ա
UPDATE  [StepApprovers] SET ApproveStatus = -1 WHERE WorkInsID = {WorkInstancesID} AND Approver IN ({UserID})


--*ͼֽ�ϴ�����  
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*�����û����������*/
INSERT [dbo].[StepApprovers] (WorkInsID, WorkStepID, FromApprover,Approver, ApproveStatus) 
VALUES ({WorkInstancesID}, @NextStepID,{AccountCode}, dbo.func_hn_getFromApprover( {WorkInstancesID},{UserID}), N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}  AND WorkStepID = @WorkStepID



--*������ƾ���ͨ��
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
/*--ѭ��ִ����Ӳ���*/
While Len(@UserList) > 0
Begin
Set @idx = Charindex(',', @UserList);
/*--ֻ��һ������*/
If @idx = 0 and Len(@UserList) > 0
Begin
INSERT [dbo].[StepApprovers] (WorkInsID, WorkStepID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID},@NextStepID,{AccountCode}, @UserList, N'0');= @WorkStepID
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {AccountCode} AND WorkStepID = @WorkStepID
Break;
End
/*--��������*/
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



--��ȡ��鵥λ�ݴ���Ŀ
SELECT a.autoid,a.ProjCode ,a.ProjName,a.ProcessingStage ,a.ProjStatus ,a.BusinessType ,a.EngineeringCategories ,a.EngineeringType
FROM T_HN_Main a 
INNER join T_HN_Main_CensorshipInfo b on a.autoid = b.mainid 
INNER join WorkInstances c on a.WorkInstancesID = c.ID
WHERE b.CI_AccountCode = {AccountCode} and a.RoleType in ('3') and c.WorkStepsID = 5 AND b.CI_IsSetManager = 0 order by CreateOn desc



--����ͼ��������������� 
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*�����û����������*/
INSERT [dbo].[StepApprovers] (WorkInsID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID}, {AccountCode},{UserID}, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}
UPDATE  [StepApprovers] SET ApproveStatus = 0 WHERE WorkInsID = {WorkInstancesID} AND ApproveStatus = -1

--����ͼ��������������� 
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*�����û����������*/
INSERT [dbo].[StepApprovers] (WorkInsID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID}, {AccountCode},{UserID}, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}  


--����ͼ��������Ŀ�����׼��Ŀ 
DECLARE @WorkID    NVARCHAR(20);
DECLARE @WorkStepID    NVARCHAR(20);
DECLARE @NextStepID    NVARCHAR(20);
DECLARE @NextStep  nvarchar(20); 
SELECT @WorkID = WorkID,@WorkStepID =WorkStepID FROM WorkInstances WHERE ID = {WorkInstancesID}; 
SELECT @NextStepID = NextStepID,@NextStep = Step  FROM WorkSteps WHERE WorkID =@WorkID AND ID = @WorkStepID 
Update WorkInstances set WorkStep =@NextStep ,WorkStepID =@NextStepID  where ID = {WorkInstancesID} 
/*�����û����������*/
INSERT [dbo].[StepApprovers] (WorkInsID,FromApprover, Approver, ApproveStatus) 
VALUES ({WorkInstancesID}, {AccountCode},{UserID}, N'0');
UPDATE  [StepApprovers] SET ApproveStatus = 1 WHERE WorkInsID = {WorkInstancesID} AND Approver = {UserID}

/*�Զ����һЩ����Begin*/
CREATE FUNCTION dbo.func_hn_getFromApprover(@WorkInstancesID varchar(8),@UserID varchar(50)) 
--CREATE FUNCTION �������ƣ�@������ �������������ͣ�
RETURNS varchar(20)   --���ط���ֵ����������
--[WITH ENCRYPTION]  --���ָ���� encryption ����������
as
BEGIN
    declare @result_name varchar(20)
	SELECT  @result_name = FromApprover FROM  StepApprovers  WHERE WorkInsID = @WorkInstancesID AND Approver = @UserID  
  RETURN  @result_name
END
/*�Զ����һЩ����END*/ 