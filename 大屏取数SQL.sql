--1.项目取数
select 
SurveyNum = (select count(1) as SurveyNum from T_HN_Main a
inner join T_HN_Main_SurveyDesignUnit b on a.ID = b.MainID
where b.SD_DesignContent = '1' and a.CREATETIME >= '' and a.CREATETIME <= ''),
 
BuildNum = (select count(1) as BuildNum from T_HN_Main a
inner join T_HN_Main_ProjGeneralInfo b on a.ID = b.MainID
where b.PG_ProjType = '1' and a.CREATETIME >= '' and a.CREATETIME <= ''), 

GovernmentNum = (select count(1) as GovernmentNum from T_HN_Main a
inner join T_HN_Main_ProjGeneralInfo b on a.ID = b.MainID
where b.PG_ProjType = '2' and a.CREATETIME >= '' and a.CREATETIME <= ''),

CivilNum = (select count(1) as CivilNum from T_HN_Main a
inner join T_HN_Main_ProjInfo b on a.ID = b.MainID
where b.PI_JoinReview = '1' and a.CREATETIME >= '' and a.CREATETIME <= ''),

FireNum = (select count(1) as FireNum from T_HN_Main a
inner join T_HN_Main_ProjGeneralInfo b on a.ID = b.MainID
where b.PG_ProjType = '3' and a.CREATETIME >= '' and a.CREATETIME <= ''),

GreenNum = (select count(1) as GreenNum from T_HN_Main a
inner join T_HN_Main_BuildingInfo b on a.ID = b.MainID
where b.BI_IsGreenProject = '1' and a.CREATETIME >= '' and a.CREATETIME <= ''),

BimNum = (select count(1)  from T_HN_Main a
inner join T_HN_Main_ProjInfo b on a.ID = b.MainID
where b.PI_IsBimTech = '1' and a.CREATETIME >= '' and a.CREATETIME <= '')

--2.单位统计
select
 BuildUnitNum = (select count(distinct(SocialCreditCode))   from T_HN_EnterpriseUser  WHERE EnterprisesType = '1' and AuditStatus = '2'  and CREATETIME >= '' and CREATETIME <= ''),
 SurveyUnitNum = (select count(distinct(SocialCreditCode))  from T_HN_EnterpriseUser  WHERE EnterprisesType = '1' and AuditStatus = '2'  and CREATETIME >= '' and CREATETIME <= ''),
 DesignUnitNum = (select count(distinct(SocialCreditCode))  from T_HN_EnterpriseUser  WHERE EnterprisesType = '1' and AuditStatus = '2'  and CREATETIME >= '' and CREATETIME <= ''),
 ReviewUnitNum = (select count(distinct(SocialCreditCode))  from T_HN_EnterpriseUser  WHERE EnterprisesType = '1' and AuditStatus = '2'  and CREATETIME >= '' and CREATETIME <= '')

--3.实效统计
--二维系统工程报审均值及各阶段平均值：
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


--一审、二审、三审时长均值
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

--正常项目，超时项目
select count(1) from WF_Instance

select  count(1) from WF_Instance a where WorkFlowTimes = '1' and status <> '10' and  datediff(day,a.CREATETIME,GETDATE()) > 10

select  count(1) from WF_Instance a where WorkFlowTimes > '1' and status <> '10' and  datediff(day,a.CREATETIME,GETDATE()) > 3


--4.项目各个阶段数量
--项目总数；
select count(1) from WF_Instance
--申报中；
select count(1) from T_HN_Main a where a.ID not in (select MainId from WF_Instance)
--审查中；
select count(1) from WF_Instance a 
inner join WF_Instance_RunningRecord b on a.ID = b.InstanceId
where b.StepCode = 'STEP_00008' and a.Status <> '10'
--整改中；
select count(1) from WF_Instance where WorkFlowTimes > '1' and status <> '10'
--已办结；
select count(1) from WF_Instance where  status = '10'

--5.项目时间分布
select 
SurveyNum = (select count(1) as SurveyNum from T_HN_Main a
inner join T_HN_Main_SurveyDesignUnit b on a.ID = b.MainID
where b.SD_DesignContent = '1' and a.CREATETIME >= '' and a.CREATETIME <= ''), 
BuildNum = (select count(1) as BuildNum from T_HN_Main a
inner join T_HN_Main_ProjGeneralInfo b on a.ID = b.MainID
where b.PG_ProjType = '1' and a.CREATETIME >= '' and a.CREATETIME <= ''), 
GovernmentNum = (select count(1) as GovernmentNum from T_HN_Main a
inner join T_HN_Main_ProjGeneralInfo b on a.ID = b.MainID
where b.PG_ProjType = '2' and a.CREATETIME >= '' and a.CREATETIME <= ''),
CivilNum = (select count(1) as CivilNum from T_HN_Main a
inner join T_HN_Main_ProjInfo b on a.ID = b.MainID
where b.PI_JoinReview = '1' and a.CREATETIME >= '' and a.CREATETIME <= ''),
FireNum = (select count(1) as FireNum from T_HN_Main a
inner join T_HN_Main_ProjGeneralInfo b on a.ID = b.MainID
where b.PG_ProjType = '3' and a.CREATETIME >= '' and a.CREATETIME <= ''),
GreenNum = (select count(1) as GreenNum from T_HN_Main a
inner join T_HN_Main_BuildingInfo b on a.ID = b.MainID
where b.BI_IsGreenProject = '1' and a.CREATETIME >= '' and a.CREATETIME <= ''),
BIMNum = (select count(1)  from T_HN_Main a
inner join T_HN_Main_ProjInfo b on a.ID = b.MainID
where b.PI_IsBimTech = '1' and a.CREATETIME >= '' and a.CREATETIME <= '')

select month(a.CREATETIME),count(1) as SurveyNum from T_HN_Main a
inner join T_HN_Main_SurveyDesignUnit b on a.ID = b.MainID
where b.SD_DesignContent = '1'
GROUP BY month(a.CREATETIME)


--6.审查质量统计
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

