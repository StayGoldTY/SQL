--չʾ����Ŀ�ı���ʱ����ƽ��ֵ��
--��άϵͳ���̱����ֵ�����׶�ƽ��ֵ��
--�����赥λ��-��Ŀ�걨ʱ����
--����Ƶ�λ��-��Ŀ�ϴ�ʱ����
--����鵥λ��-��Ŀ���ʱ����
--����Ƶ�λ��-��Ŀ����ʱ����

--һ�󡢶�������ʱ����ֵ
  
--��Ŀ����ʱ��
select CREATETIME,* from T_HN_Main  a
--order by a.CREATETIME desc
where id = '63732a88066c03c1adc23a0491e2ccdd'

--��ת��������Ƶ�λ��ʱ��

select  CREATETIME from WF_Instance  where MainId = '63732a88066c03c1adc23a0491e2ccdd' order by CREATETIME asc
--��ת����鵥λ��ʱ��
select top 1 CREATETIME from WF_Instance_RunningRecord 
where InstanceId in (select id from WF_Instance where MainId = '63732a88066c03c1adc23a0491e2ccdd')  and STEPCode = 'STEP_00008'  order by CREATETIME asc

--��Ŀ����ʱ��
select top 1 CREATETIME from WF_Instance_RunningRecord where  STEPCode = 'STEP_99999'

--�����赥λ��-��Ŀ�걨ʱ����
select top 1  cast(Sum(datediff(day,b.CREATETIME,a.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance  a
inner join T_HN_Main b on a.MainId = b.ID

--����Ƶ�λ��-��Ŀ�ϴ�ʱ����
select  top 1  cast(Sum(datediff(day,a.CREATETIME,b.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance a 
inner join WF_Instance_RunningRecord b on a.ID = b.InstanceId
where b.StepCode = 'STEP_00008'

--����鵥λ��-��Ŀ���ʱ����
select  top 1  cast(Sum(datediff(day,b.CREATETIME,a.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance_RunningRecord a 
inner join WF_Instance_RunningRecord b on a.InstanceId = b.InstanceId
where a.StepCode = 'STEP_99999' and b.StepCode = 'STEP_00008'

--����Ƶ�λ��-��Ŀ����ʱ����
select  top 1  cast(Sum(datediff(day,a.CREATETIME,b.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance a 
inner join WF_Instance_RunningRecord b on a.ID = b.InstanceId
where b.StepCode = 'STEP_00008' and a.WorkFlowTimes > '1'

---����
select reportTime = (
select top 1  cast(Sum(datediff(day,b.CREATETIME,a.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance  a
inner join T_HN_Main b on a.MainId = b.ID
),
uploadTime = (
select  top 1  cast(Sum(datediff(day,a.CREATETIME,b.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance a 
inner join WF_Instance_RunningRecord b on a.ID = b.InstanceId
where b.StepCode = 'STEP_00008'
),
reviewTime = (
select  top 1  cast(Sum(datediff(day,b.CREATETIME,a.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance_RunningRecord a 
inner join WF_Instance_RunningRecord b on a.InstanceId = b.InstanceId
where a.StepCode = 'STEP_99999' and b.StepCode = 'STEP_00008'
),
reformTime = (
select  top 1  cast(Sum(datediff(day,a.CREATETIME,b.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance a 
inner join WF_Instance_RunningRecord b on a.ID = b.InstanceId
where b.StepCode = 'STEP_00008' and a.WorkFlowTimes > '1'
)



--һ�󡢶�������ʱ����ֵ
select firstReview =(
select top 1  cast(Sum(datediff(day,a.CREATETIME,b.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance a
inner join WF_Instance_RunningRecord  b on a.ID = b.InstanceId
where a.WorkFlowTimes = '1' and a.Status = 10 and b.StepCode  = 'STEP_99999'),
secondReview =(
select  cast(Sum(datediff(day,a.CREATETIME,b.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance a
inner join WF_Instance_RunningRecord  b on a.ID = b.InstanceId
where a.WorkFlowTimes = '2' and a.Status = 10 and b.StepCode  = 'STEP_99999'),
thridReview =(
select  cast(Sum(datediff(day,a.CREATETIME,b.CREATETIME))/(count(1) +0.0) as decimal(18,2)) from WF_Instance a
inner join WF_Instance_RunningRecord  b on a.ID = b.InstanceId
where a.WorkFlowTimes = '3' and a.Status = 10 and b.StepCode  = 'STEP_99999')

--������Ŀ����ʱ��Ŀ
select count(1) from WF_Instance

select  count(1) from WF_Instance a where WorkFlowTimes = '1' and status <> '10' and  datediff(day,a.CREATETIME,GETDATE()) > 10

select  count(1) from WF_Instance a where WorkFlowTimes > '1' and status <> '10' and  datediff(day,a.CREATETIME,GETDATE()) > 3


--6.�������ͳ��
select count(1) from T_HN_Main a
inner join T_HN_Main_SurveyDesignUnit b on a.ID = b.MainID
inner join WF_Instance c on a.ID = c.MainId
where b.SD_DesignContent = '1'  and c.Status = 10 and c.WorkFlowTimes = '1'  and a.CREATETIME >= '' and a.CREATETIME <= ''

select count(1) from T_HN_Main a
inner join T_HN_Main_SurveyDesignUnit b on a.ID = b.MainID
inner join WF_Instance c on a.ID = c.MainId
where b.SD_DesignContent = '1'  and c.Status = 10   and a.CREATETIME >= '' and a.CREATETIME <= ''

select  count(1) from T_HN_Main a
inner join T_HN_Main_ProjGeneralInfo b on a.ID = b.MainID
inner join WF_Instance c on a.ID = c.MainId
where b.PG_ProjType = '1'and c.Status = 10 and c.WorkFlowTimes = '1'   and a.CREATETIME >= '' and a.CREATETIME <= ''

select count(1) as GovernmentNum from T_HN_Main a
inner join T_HN_Main_ProjGeneralInfo b on a.ID = b.MainID
inner join WF_Instance c on a.ID = c.MainId
where b.PG_ProjType = '2' and c.Status = 10 and c.WorkFlowTimes = '1'  and a.CREATETIME >= '' and a.CREATETIME <= ''

select count(1) as CivilNum from T_HN_Main a
inner join T_HN_Main_ProjInfo b on a.ID = b.MainID
inner join WF_Instance c on a.ID = c.MainId
where b.PI_JoinReview = '1'and c.Status = 10 and c.WorkFlowTimes = '1'   and a.CREATETIME >= '' and a.CREATETIME <= ''

select count(1) as FireNum from T_HN_Main a
inner join T_HN_Main_ProjGeneralInfo b on a.ID = b.MainID
inner join WF_Instance c on a.ID = c.MainId
where b.PG_ProjType = '3'and c.Status = 10 and c.WorkFlowTimes = '1'   and a.CREATETIME >= '' and a.CREATETIME <= ''

select count(1) as GreenNum from T_HN_Main a
inner join T_HN_Main_BuildingInfo b on a.ID = b.MainID
inner join WF_Instance c on a.ID = c.MainId
where b.BI_IsGreenProject = '1'and c.Status = 10 and c.WorkFlowTimes = '1'   and a.CREATETIME >= '' and a.CREATETIME <= ''

select count(1)  from T_HN_Main a
inner join T_HN_Main_ProjInfo b on a.ID = b.MainID
inner join WF_Instance c on a.ID = c.MainId
where b.PI_IsBimTech = '1'and c.Status = 10 and c.WorkFlowTimes = '1'   and a.CREATETIME >= '' and a.CREATETIME <= ''


--7.��ǿ����ֵͳ�ơ�
select count(1) from T_WORK_COMMENTS where WID in (select c.ID from T_HN_Main a
inner join T_HN_Main_SurveyDesignUnit b on a.ID = b.MainID
inner join WF_Instance c on a.ID = c.MainId
where b.SD_DesignContent = '1'  and a.CREATETIME >= '' and a.CREATETIME <= '')

--8.��Υ��ǿ��ͳ�ơ�