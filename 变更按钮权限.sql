--������Ŀ															ImportProjBtn      
--����																SaveBtn     
--������Ʊ��														DesignBeginBtn
--���쵥λȷ�ϱ��													KCConfirm
--���赥λȷ�ϱ��													JSConfirm
--���쵥λ������Ŀ����(Ϊ0��ʱ����ʾ�鿴��ť)						KCSetManagerBtn        
--ʩ��ͼ��λ������Ŀ����(Ϊ0��ʱ����ʾ�鿴��ť)						SGTSetManagerBtn   
--�����������														KCTaskStaffsBtn 
--ʩ��ͼ�������													SGTTaskStaffsBtn       
--ͼֽ�����ύ														SubmitBtn              
--�������(��Ŀ����ȷ��)											BeginReviewBtn 
--������ͼ��λ������Ŀ����(Ϊ0��ʱ����ʾ�鿴��ť)					KCSTSetManagerBtn   
--ʩ��ͼ��ͼ��λ������Ŀ����(Ϊ0��ʱ����ʾ�鿴��ť)					SGTSTSetManagerBtn    
--��������������													ZCXToDoBtn  
--��������������													JSXZCXToDoBtn  
--�����Ӹ���ͼר����(��Ŀ�����׼��Ŀ)								ProjectEndBtn

--sp_helptext 'GetEditToDoProject'

--Exec GetEditToDoProject 'hdd','239'
--DROP proc GetEditToDoProject

create proc GetEditToDoProject
@AccountCode nvarchar(50),
@WorkInstancesID nvarchar(50) 
as
begin
declare @ProcessingType  int; declare @WorkStepID  int;declare @ApproveStatus  int;
declare @WorkID  int;
SELECT @WorkStepID = c.WorkStepID,@ApproveStatus = c.ApproveStatus,@WorkID = b.WorkID
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode and  charindex(c.WorkInsID,@WorkInstancesID) > 0  AND c.ApproveStatus = 0;  

SELECT @ProcessingType = c.WorkStepID
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.FromApprover = @AccountCode  AND  charindex(c.WorkInsID,@WorkInstancesID) > 0;  



if @WorkStepID is null and @ProcessingType is null begin
SELECT top 1 
1 as ImportProjBtn ,1 as SaveBtn,1 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
end

if @WorkStepID is null and @ProcessingType is not null begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
end

if @WorkStepID =2 and @ApproveStatus = 0 AND (@WorkID = 1 OR @WorkID = 2) BEGIN
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn,0 AS KCConfirm,0 AS JSConfirm ,CASE d.SD_DesignContent WHEN 1 THEN 1 ELSE 0 END  as KCSetManagerBtn,CASE d.SD_DesignContent WHEN 2 THEN 1 ELSE 0 END as SGTSetManagerBtn,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a  
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
INNER JOIN T_HN_Main_SurveyDesignUnit d ON a.autoid = d.mainid
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0  and c.WorkInsID = @WorkInstancesID AND d.SD_WorkInstancesID = @WorkInstancesID;
END

if @WorkStepID =2 and @ApproveStatus = 0 AND @WorkID = 3 BEGIN
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn,1 AS KCConfirm,0 AS JSConfirm ,0  as KCSetManagerBtn,0 as SGTSetManagerBtn,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a  
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
INNER JOIN T_HN_Main_SurveyDesignUnit d ON a.autoid = d.mainid
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0  and c.WorkInsID = @WorkInstancesID AND d.SD_WorkInstancesID = @WorkInstancesID;
end

if @WorkStepID =2 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;

end

if @WorkStepID =3 and @ApproveStatus = 0 AND (@WorkID = 1 OR @WorkID = 2) BEGIN
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
CASE d.SD_DesignContent WHEN 1 THEN 1 ELSE 0 END  as KCTaskStaffsBtn ,CASE d.SD_DesignContent WHEN 1 THEN 0 ELSE 1 END as SGTTaskStaffsBtn 
 ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
INNER JOIN T_HN_Main_SurveyDesignUnit d ON a.autoid = d.mainid
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID AND d.SD_WorkInstancesID = @WorkInstancesID;
END

if @WorkStepID =3 and @ApproveStatus = 0 AND @WorkID = 3  BEGIN
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,1 AS JSConfirm,
0 as  KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID;
end


if @WorkStepID =3 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0  as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;

end

if @WorkStepID =4 and @ApproveStatus = 0 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as  KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn  ,1 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID;

end

if @WorkStepID =4 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as  KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn  ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;
end


if @WorkStepID =5 and @ApproveStatus = 0 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as  KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn  ,0 as SubmitBtn ,1 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID;
end

if @WorkStepID =5 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as  KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn  ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;
end


if @WorkStepID =6 and @ApproveStatus = 0 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,1 AS JSConfirm,
0 as  KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn  ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID;
end

if @WorkStepID =6 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as  KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn  ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;
end


if @WorkStepID =7 and @ApproveStatus = 0 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 AS  KCSetManagerBtn , 0  as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn  
 ,0 as SubmitBtn ,
0 as  BeginReviewBtn ,CASE d.CI_ReviewContent WHEN 1 THEN 1 ELSE 0 END  as KCSTSetManagerBtn,CASE d.CI_ReviewContent WHEN 2 THEN 1 ELSE 0 END  as SGTSTSetManagerBtn,
0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a  
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
INNER JOIN T_HN_Main_CensorshipInfo d ON a.autoid = d.mainid
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID AND d.CI_WorkInstancesID = @WorkInstancesID;
end


if @WorkStepID =7 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn   ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;

end

if @WorkStepID =8 and @ApproveStatus = 0 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
CASE d.CI_ReviewContent WHEN 1 THEN 1 ELSE 0 END  as KCTaskStaffsBtn ,CASE d.CI_ReviewContent WHEN 1 THEN 0 ELSE 1 END as SGTTaskStaffsBtn 
,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
INNER JOIN T_HN_Main_CensorshipInfo d ON a.autoid = d.mainid
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID AND d.CI_WorkInstancesID = @WorkInstancesID;
end


if @WorkStepID =8 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn    ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;
end


if @WorkStepID =9 and @ApproveStatus = 0 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn    ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,1 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID;

end

if @WorkStepID =9 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn    ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;

end

if @WorkStepID =10 and @ApproveStatus = 0 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn    ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,1 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a  
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID;
end

if @WorkStepID =10 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn    ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;

end

if @WorkStepID =11 and @ApproveStatus = 0 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn    ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,1 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 0 and c.WorkInsID = @WorkInstancesID;

end

if @WorkStepID =11 and @ApproveStatus = 1 begin
SELECT top 1 
0 as ImportProjBtn ,0 as SaveBtn,0 as  DesignBeginBtn ,0 as KCSetManagerBtn,0 as SGTSetManagerBtn,0 AS KCConfirm,0 AS JSConfirm,
0 as KCTaskStaffsBtn ,0 as SGTTaskStaffsBtn    ,0 as SubmitBtn ,0 as  BeginReviewBtn ,0 as KCSTSetManagerBtn,0 as SGTSTSetManagerBtn,0 as ZCXToDoBtn,0 as JSXZCXToDoBtn	,0 as  ProjectEndBtn
FROM T_HN_Main a 
INNER join WorkInstances b on  charindex(CAST(b.ID AS VARCHAR(10)),a.WorkInstancesID) > 0
INNER JOIN StepApprovers c ON c.WorkInsID = b.ID
WHERE c.Approver = @AccountCode   AND c.ApproveStatus = 1 and c.WorkInsID = @WorkInstancesID;
end
end



