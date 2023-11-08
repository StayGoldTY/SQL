--1修改合格书取值的存储过程
sp_helptext 'usp_Censorship_GetFormData'
--2企业信息丢失更新
update T_HN_EnterpriseUser set AuditStatus = '0',RoleName = 'QYGuest'
where id = 'a63b388a54434f134b5e3a04a1c7bbe4'

--3替换合格书上面技术负责人
select *                         
     from T_HN_ProjectManager where SetStage = '2' and isNUll(DeletionStateCode,'0') <> '1' and MainID = '324f44ac51dfbd572be63a081c2eca32'

	 select * from T_HN_PersonalUser  where username = '460102199401183026'

	  select * from T_HN_PersonalUser  where RegistrantName = '曹诚'

	  update T_HN_ProjectManager set ProjManagerID = '230102196405101933' where id = 'a821520585bbe166b40a3a08b5a63a64'
--4修复流程要更新的三个主要表
update WF_Instance set CurrentStep = '98fea82929b8a346839139fe97578cc7'  where id = '484e6f2596cbda75a9d73a088de3d357'
GO
update WF_Task set Status = '0' where id= '413994c474ea1bda17953a08b73d2014'
GO
update WF_Instance_RunningRecord set Status = '0' where id = 'ede4c066652e7213e8433a08b73d200e'

--情况2

update  WF_Task set  WfStepDefinitionId = '98fea82929b8a346839139fe97578cc7' ,Status = 0 where id = '413994c474ea1bda17953a08b73d2014'

update WF_Instance  set CurrentStep = '98fea82929b8a346839139fe97578cc7'   where  id = '413994c474ea1bda17953a08b73d2014' 

update WF_Instance_RunningRecord  set WfStepDefinitionId = '98fea82929b8a346839139fe97578cc7',StepCode = 'STEP_00006'   where  id = '746536b507e53f2f9d6b39feb29c6eb9' 

--情况三，驳回到施工图子流程最后一步
update WF_Instance set CurrentStep = '62a374e9bbd4ee6ab39a39fe9278bae4',Status ='1'  where id = '780434958e396b1417e23a0c36f763df'
GO
update WF_Task set Status = '0' where id= '085e0de40a1db1576b833a0c371930cf'
GO
update WF_Instance_RunningRecord set Status = '0' where id = '3bf89eaa143f8929f10f3a0c37193088'
go
DELETE WF_Instance_RunningRecord WHERE ID = 'faf8ed9589ab371d068c3a0c37194c67'

---情况四，联合涉及驳回
--查询sql 
SELECT * FROM WF_Instance_RunningRecord  WHERE InstanceId  IN (SELECT ID FROM WF_Instance  WHERE MainId = '1f9340ed98e50fb4eaaa3a0c1c30ef9b')  ORDER BY CREATETIME  DESC
GO
update WF_Instance set CurrentStep = '62a374e9bbd4ee6ab39a39fe9278bae4',Status ='1'  where id = '857a3672ec8e3b09afc03a0ca2702d48'
GO
update WF_Task set Status = '0' where id= 'c2b9b151bb573eff68403a0ca8f94299'
GO
update WF_Instance_RunningRecord set Status = '0' where id = '49c67d5bbd0378763c0c3a0ca8f9424f'
go
DELETE WF_Instance_RunningRecord WHERE ID = 'd10b30868d6eeed2522c3a0cbcb2f3e3'

--联合涉及的查看一下孙子流程的父节点是否已经完成，如果完成的话，要置为未完成

SELECT * FROM WF_Instance  WHERE  ID = 'bb903eb2ac7d7c6a206b3a0c1c318d61'

update WF_Instance  set Status = '1'  WHERE  ID = 'bb903eb2ac7d7c6a206b3a0c1c318d61'

--5更新合格书
SELECT DeletionStateCode,* FROM T_HN_ProjDoc  WHERE ListID = '6' AND MAINID = '22135cc25ad3a87ebd573a08753f11c9'
ORDER BY CREATETIME DESC

UPDATE T_HN_ProjDoc SET DeletionStateCode = '0'  WHERE ID = '5332180dcde0d73b9da63a08bb851929'

UPDATE T_HN_ProjDoc SET DeletionStateCode = '1'  WHERE ID = 'd4d054b56883f64583dc3a089730a454'

--6勘察设计单位未设置人员直接点击通过了
UPDATE WF_Task SET UserOrRoleId= '460103199212231531' WHERE ID = 'a2e7a223c45f5ac8ee693a08b5b38165'
--让后让其驳回重新设置人员，因为T_HN_TaskStaff表的数据也没有


--7流程结束退后到最后一步
select * from WF_Instance where id = '22bf7385fb1bcb15366c3a089721a636'
select * from WF_Task where InstanceId = '22bf7385fb1bcb15366c3a089721a636' order by CREATETIME desc
select * from WF_Instance_RunningRecord where InstanceId = '22bf7385fb1bcb15366c3a089721a636' order by CREATETIME desc
--施工图
update WF_Instance set CurrentStep = 'ea84b0565f28356bcce13a030fda9049',Status = '1'  where id = '054df59f22d3cfccf68e3a088912bc60'
--勘察
update WF_Instance set CurrentStep = '3aaa2d67759f19afd4d43a031426dbc9',Status = '1'  where id = '05e488693d8762f99dd63a0be87daf38'
GO
GO
update WF_Task set Status = '0' where id= '750c3f27a397541a3c783a091e9378ae'
GO
delete WF_Instance_RunningRecord  where id = 'e2e02c65a216155bd2293a09220a0336'
GO
update WF_Instance_RunningRecord set Status = '0' where id = '420210a6ef8c7e2514413a091e9378aa'


--8手动替换合格书意见书 （前提把listid 6的edit设置为1）
select DeletionStateCode,* from T_HN_ProjDoc  where mainid = '129480775ca7ed665e053a0983ed6c1d' and listid = '6' order by CREATETIME desc

update T_HN_ProjDoc set DeletionStateCode = '0'  where id = '0eeecf5077568c38f0a83a09ad078d5e'

update T_HN_ProjDoc set DeletionStateCode = '1'  where id = 'aa6a07a48c3d8e4a4ca33a09a8c598e3'


select * from WF_Task where InstanceId = 'c7646c4f9aad3c3a82233a0863aa3261' order by CREATETIME desc

update WF_Task set status = '1' where id = '8e0065c29dbcb0a6b7863a08bb4020a8'

--9查询工改推送的信息
SELECT prjid,BreakerId,* FROM T_P_PrjBaseInfo WHERE prjid LIKE '%2206-465104-04-01-831077%' 

SELECT * FROM QGC2_Base_UnitEngineeringInfo  WHERE ProjectGuid   LIKE '%a3d5fe6bd832450bb142a34d9bb6ad88%'   and updatestatus > 0

--修改审查意见
select * from T_WORK_COMMENTS  where wid = '80b9b1e833ffbd2de2213a098541f25f' and COMMNETS like '%P73%'

SELECT * FROM T_WORK_COMMENTS  WHERE ID = 'yPTrCTGiCAaQl2UAc9Pj'

UPDATE  T_WORK_COMMENTS SET REVIEWCAT = 'bd9cd1b5e533c7fe991739fbeadab4d0' WHERE ID = 'yPTrCTGiCAaQl2UAc9Pj'

SELECT * FROM T_STDS_AUDIT


---10文件替换专业
begin tran
UPDATE  T_HN_ProjDoc  SET MajorID =  CASE  WHEN CHARINDEX('5.1.2',listid) > 0 then 2    WHEN CHARINDEX('5.2.2',listid) > 0 then 3    WHEN CHARINDEX('5.3.2',listid) > 0 then 4
   WHEN CHARINDEX('5.4.2',listid) > 0 then 5    WHEN CHARINDEX('5.5.2',listid) > 0 then 6    WHEN CHARINDEX('5.6.2',listid) > 0 then 7 WHEN CHARINDEX('10.2.2',listid) > 0 then 10 WHEN CHARINDEX('10.3.2',listid) > 0 then 11   WHEN CHARINDEX('10.4.2',listid) > 0 then 12 WHEN CHARINDEX('10.7.2',listid) > 0 then 15  else MajorID end
  WHERE MajorID = '1' and  CHARINDEX('ry',CREATEBY) = 0  and CHARINDEX('4.1.',listid) = 0
rollback tran

--更换文件替换
DELETE T_HN_Main_SingleBidSection  WHERE MAINID = '9bab6436f9e837da525f3a09f5a62ad2'

 UPDATE T_HN_Main_SingleBidSection SET MainID = '9bab6436f9e837da525f3a09f5a62ad2'
 WHERE MAINID = '4c398cb9cd44b87ed6453a08bd0c4d26'

 UPDATE T_HN_ProjDoc SET MainID = '9bab6436f9e837da525f3a09f5a62ad2'  WHERE MAINID = '4c398cb9cd44b87ed6453a08bd0c4d26'

--11推送腾龙检查语句
select * from T_P_kcsj_kccgscxx where gcmc like '%亚博园%'
select * from T_P_kcsj_kczsxx where gcmc like '%亚博园%'
select * from T_P_kcsj_kczyjsry where prjcode like '%2023FW000141%'
select * from T_P_kcsj_sgtscxx where prjcode like '%2023FW000141%'
select * from T_P_kcsj_sgtsczsxx where gcmc like '%亚博园%'
select * from T_P_kcsj_sgtsczyjsry where prjcode like '%2023FW000141%'
select * from T_P_kcsj_sgtwfbzdj where prjcode like '%2023FW000141%'
select * from QGC2_Base_UnitEngineeringInfo where Prjid like '%2212-469002-04-01-763842%'
--TO BE CHECK
select * from New_TBUnitProjectInfo where SubPrjName like '%亚博园%'
select * from New_TBProjectCorpInfo where gcmc like '%亚博园%'
select * from New_TBProjectCensorInfo where gcmc like '%亚博园%'
select * from New_TBDesignEconUserInfo where gcmc like '%亚博园%'
select * from New_TBProjectDesignErrInfo where gcmc like '%亚博园%'

select * from T_P_kcsj_kccgscxx 
select * from T_P_kcsj_kczsxx 
select * from T_P_kcsj_kccydw
select * from T_P_kcsj_kczyjsry 
select * from T_P_kcsj_kczyjsry_ryxx

select * from T_P_kcsj_sgtscxx 
select * from T_P_kcsj_sgtsczsxx 
select * from T_P_kcsj_tscydw
select * from T_P_kcsj_sgtsczyjsry 
select * from T_P_kcsj_sgtsczyjsry_ryxx

delete T_P_kcsj_kccgscxx 
delete T_P_kcsj_kczsxx 
delete T_P_kcsj_kccydw
delete T_P_kcsj_kczyjsry 
delete T_P_kcsj_kczyjsry_ryxx 


delete T_P_kcsj_sgtscxx 
delete T_P_kcsj_sgtsczsxx 
delete T_P_kcsj_tscydw
delete T_P_kcsj_sgtsczyjsry 
delete T_P_kcsj_sgtsczyjsry_ryxx

--12删除项目
SELECT DeletionStateCode,* FROM t_hn_mAIN WHERE ProjCode = '2023FW000233'

UPDATE t_hn_mAIN  SET DeletionStateCode = '1' WHERE ProjCode = '2023FW000233'

SELECT * FROM WF_Instance  WHERE MAINID = '4c398cb9cd44b87ed6453a08bd0c4d26'

DELETE WF_Instance WHERE MAINID = 'd8253ae6af9772cd785e3a08d5227ba8'

--13修改了图审单位的修复语句 

select CI_WorkInstancesID,* from T_HN_Main_CensorshipInfo where mainid = '6bcee16cb7a53542d9873a09a30776e7'

select * from WF_Instance where id = 'ede6d246112ae96138773a09b36a29e8'
select * from WF_Task where InstanceId = 'ede6d246112ae96138773a09b36a29e8' order by CREATETIME  desc
select * from WF_Instance_RunningRecord where InstanceId = 'ede6d246112ae96138773a09b36a29e8' order by CREATETIME  desc

select * from WF_Definition  where id = '13efb8102e080eaffa5739fe928f13e2'
--勘察
update T_HN_Main_CensorshipInfo set CI_WorkInstancesID = '344899e66594446fef7d3a09d6959e8e' where mainid = 'a2d1c209c812d91b73663a09d66de325'
update  WF_Task set Status = 0 where id = '5d9eb411a62d9f34187f3a0a14023a86'

update WF_Instance  set CurrentStep = '4ed9880ff83da0d52bc139fe928ca424'   where  id = 'ede6d246112ae96138773a09b36a29e8' 

delete WF_Instance_RunningRecord where id = '9115d6806cae56c5f36e3a0a151a6ec8'
update WF_Instance_RunningRecord  set Status = '0'   where  id = '25f8b3e93026fa69db583a0a14023a86' 


-
--14住建厅统计信息
select sum(a) from (select sum( CAST(isnull(BI_BuildingArea,'0') as float)) as a from T_HN_Main_BuildingInfo a 
left join T_HN_main b on  a.MainID = b.ID
where ISNUMERIC(BI_BuildingArea) = 1 and  BI_BuildingArea <> '-' and
isnull(b.DeletionStateCode,'0') <> '1'  and b.AccountCode <> 'jianshe' and a.CREATETIME  >= '2023/01/01' and b.ProjStatus = '10'
group by a.MainID) k


select sum(a) from (select sum( CAST(isnull(BI_BuildingArea,'0') as float)) as a from T_HN_Main_BuildingInfo a 
left join T_HN_main b on  a.MainID = b.ID
left join T_HN_Main_ProjGeneralInfo c on a.MainID = c.MainID
where ISNUMERIC(BI_BuildingArea) = 1 and  BI_BuildingArea <> '-' and
isnull(b.DeletionStateCode,'0') <> '1'  and b.AccountCode <> 'jianshe' and a.CREATETIME  >= '2023/01/01' and b.ProjStatus = '10'
and (c.PG_ConType like '%居住建筑%' or c.PG_ConType like '%公共建筑%')
group by a.MainID) k

select TitleName,* FROM T_HN_PersonalInformation  WHERE TitleName = '7'

--邹工统计信息sql
--目前全省已有XXX个项目办结，XXX份数字化勘察报告和施工图纸，XXX名审查人员通过在线资格认定，副高级职称占比XX，注册执业资格占比XX，60岁以下占比XX
select count(*) from T_HN_EnterpriseUser where EnterprisesType = '2' and  AuditStatus = '2' 

select  count (*) from T_HN_PersonalUser  where UserType = '2' and AuditStatus = '2'

select  count (*) from T_HN_PersonalUser  where UserType = '4' and AuditStatus = '2'

select COUNT(*) FROM T_HN_PersonalInformation  WHERE TitleName = '7' AND USERNAME IN (select  USERNAME from T_HN_PersonalUser  where UserType = '4' and AuditStatus = '2')


select  count (*) from T_HN_PersonalUser a where a.username in (
SELECT username FROM T_HN_PersonalInformation
WHERE Birthday IS NOT NULL 
  AND Birthday LIKE '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
  AND DATEDIFF(YEAR, CAST(Birthday AS DATE), GETDATE()) < 60)  and a.UserType = '4' and a.AuditStatus = '2'

select count(*) from T_HN_Main where ProjStatus = '10' and isnull(DeletionStateCode,'0') != '1' and BusinessType = '0'

select count(*) from T_HN_ProjDoc  where ListID <> '6' and isnull(DeletionStateCode,'0') != '1' and  DocType  is null



--15企业或者个人变成游客状态
select RoleName,AuditStatus,* from T_HN_EnterpriseUser  where User_Name = '913611007165354813'

delete  T_HN_EnterpriseUser  where id in ('641fd1a082e8df32d4b23a0a66855d3d','8fa2b9dad6916ae4e43a3a0a66855d42','f6fc90a9b0d7f36328513a0a66855d41')

select usertype,rolename,* from T_HN_PersonalUser  where username = '460006198711214014'

delete T_HN_PersonalUser where id in ('d78401cbb95345ac41cb3a0a66853dec','8680f204a5cfb0e952913a0a66853844','81682b2c0252c652b7e53a0a66853846')

--16四库平台的相关的表
select LASTUPDATEDATE,* from  New_TBProjectCorpInfo a order by a.LASTUPDATEDATE desc

select LASTUPDATEDATE,* from  New_TBProjectCensorInfo a order by a.LASTUPDATEDATE desc

select LASTUPDATEDATE,* from  New_TBDesignEconUserInfo a order by a.LASTUPDATEDATE desc

select LASTUPDATEDATE,* from  New_TBProjectDesignErrInfo a order by a.LASTUPDATEDATE desc

--17单独删除某一流程，比如勘察或者施工图
select ProjName,* from T_HN_Main where id = '4165b46d780f9c0518ae3a0a7b538b26'

SELECT * FROM t_hn_mAIN WHERE ProjCode = '2023FW000845'

SELECT * FROM WF_Instance  WHERE MAINID = 'bdcf8dd2dcdf0b50f8cf3a0a47ba7de2'

DELETE WF_Instance WHERE ID = '20e5127a63b42fec7df33a0a47bab14f'
DELETE WF_Instance  where FatherId = '0f7858b68e7de5df53833a0a3d595db1'
SELECT * FROM T_HN_Main_SurveyDesignUnit WHERE MAINID = 'bdcf8dd2dcdf0b50f8cf3a0a47ba7de2'
DELETE T_HN_Main_SurveyDesignUnit WHERE ID = '3e716a57580661c31a3d3a0acd41df6c' and SD_DesignContent = '1'
SELECT * FROM T_HN_Main_CensorshipInfo WHERE MAINID = 'bdcf8dd2dcdf0b50f8cf3a0a47ba7de2'
DELETE T_HN_Main_CensorshipInfo WHERE ID = '9ae1b21298cafdf09e083a0acd41df6c' and CI_ReviewContent ='1'

--18删除所有temp开头的表
DECLARE @sql NVARCHAR(MAX) = N'';
SELECT @sql += N'DROP TABLE IF EXISTS ' + QUOTENAME(TABLE_SCHEMA) + N'.' + QUOTENAME(TABLE_NAME) + N';'
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' AND TABLE_NAME LIKE 'temp%';
EXEC sp_executesql @sql;

--19批量更新文件大小
begin tran
update T_HN_ProjDoc 
set FileSize = c.F_FileSizeOfBytes
from  T_HN_ProjDoc a
left join   RecFile.dbo.Upload_File b on a.FileCode = b.F_Id
left join   RecFile.dbo.Base_File c on b.F_FileRef = c.F_Id

rollback tran

--联合查询更新

--20 住建厅领导查询sql

select distinct    a.ProjName as 项目名称, 
b.PI_Province + b.PI_City + b.PI_District AS 项目地址,

cast(c.BI_BuildingArea as numeric(18,2)) as 总建筑面积,
c.BI_AbovegroundLayerNum as 地上层数,
isnull(d.CompanyName,e.RegistrantName) as  建设单位,
isnull(f.ContactsPhone,e.Telephone) as 联系方式
 from T_HN_Main a 
left join T_HN_Main_ProjInfo  b  on  a.ID = b.MainID
left join T_HN_Main_BuildingInfo c on a.id = c.MainID  and  ISNUMERIC(c.BI_BuildingArea) = 1
left join T_HN_EnterpriseUser d on a.AccountCode   = d.User_Name
left join T_HN_BuildEnterpriseInfo f on a.AccountCode = f.User_Name
left join T_HN_PersonalUser e on a.AccountCode = e.username
where b.PI_District = '秀英区' and a.AccountCode <> 'jianshe'
order by 总建筑面积

SELECT distinct d.ProjName as 项目名称, a.PictureNumber + '万元' as 勘察合同金额,  c.CompanyName as 勘察单位
FROM T_HN_ProjDoc a
inner join T_HN_Main_SurveyDesignUnit  b on a.MainID = b.MainID
inner join T_HN_EnterpriseUser  c  on b.SD_UnitCode = c.User_Name
inner join T_HN_Main  d  on d.ID  = a.MainID
WHERE a.ListID = '30' 
  AND ISNUMERIC(a.PictureNumber) = 1 
  AND ISNULL(a.DeletionStateCode, '0') <> '0'
  and b.SD_DesignContent = '1'
    and a.CREATEBY <> 'sheji'


SELECT distinct d.ProjName as  项目名称,a.PictureNumber + '万元' as 设计合同金额,  c.CompanyName as 设计单位
FROM T_HN_ProjDoc a
inner join T_HN_Main_SurveyDesignUnit  b on a.MainID = b.MainID
inner join T_HN_EnterpriseUser  c  on b.SD_UnitCode = c.User_Name
inner join T_HN_Main  d  on d.ID  = a.MainID
WHERE a.ListID = '30' 
  AND ISNUMERIC(a.PictureNumber) = 1 
  AND ISNULL(a.DeletionStateCode, '0') <> '0'
  and b.SD_DesignContent = '2'
  and a.CREATEBY <> 'sheji'

--杨瀚要求查询语句
--上半年(2023.1-6.30)项目名称、总投资额(有数据的项目才算)、建设单位、设计单位、设计单位注册地址、设计单位资质等级、设计合同费用、图审单位、图审单位注册地址、图审合同费用。
--以及省内外设计单位占比，你下午的话，看有时间给他导一下？
WITH ProjDoc_CTE AS (
    SELECT MainID, CREATEBY, ListID, PictureNumber,
    ROW_NUMBER() OVER(PARTITION BY MainID, CREATEBY, ListID ORDER BY PictureNumber) AS rn
    FROM T_HN_ProjDoc
)
SELECT distinct  A.ProjName as 项目名称,B.PG_TotalAmount as '总投资额(万元)',A.AccountName as 建设单位,c.SD_SurveyDesignUnitName as 设计单位,
(f.UnitProvince+f.UnitCity+ f.UnitDistrict + f.UnitAddress) as 设计单位注册地址,
STUFF((SELECT ', ' + CASE 
  WHEN g.EQ_QualificationLevel = '1' THEN '甲级'
  WHEN g.EQ_QualificationLevel = '2' THEN '乙级'
  WHEN g.EQ_QualificationLevel = '3' THEN '丙级'
  WHEN g.EQ_QualificationLevel = '4' THEN '丁级'
  WHEN g.EQ_QualificationLevel = '5' THEN '不分等级'
  ELSE g.EQ_QualificationLevel
END
FROM T_HN_DesignEnterpriseInfo_QLevel g 
WHERE f.ID = g.mainid
FOR XML PATH('')), 1, 2, '') as 设计单位资质等级,
i.PictureNumber as 设计合同费用, d.CI_ReviewUnitName as 图审单位, (h.RegisterProvince+h.RegisterCity+ h.RegisterDistrict + h.RegisterAddress) as 图审单位注册地址,j.PictureNumber as 图审合同费用
FROM t_hn_mAIN A
LEFT JOIN  T_HN_Main_ProjGeneralInfo  B ON A.ID = B.MainID
left join T_HN_Main_SurveyDesignUnit c on a.ID = c.MainID
left join T_HN_Main_CensorshipInfo d on a.ID = d.MainID
left join T_HN_DesignEnterpriseInfo f on c.SD_UnitCode = f.User_Name
left join T_HN_DesignEnterpriseInfo_QLevel g on f.ID = g.mainid
left join T_HN_ReviewEnterpriseInfo h on d.CI_UnitCode = h.User_Name
left join ProjDoc_CTE i on a.id = i.MainID and i.CREATEBY = c.SD_UnitCode and i.ListID = '30' and i.rn = 1
left join ProjDoc_CTE j on a.id = j.MainID and j.CREATEBY = d.CI_UnitCode  and j.ListID = '30' and j.rn = 1
WHERE B.PG_TotalAmount IS NOT NULL AND B.PG_TotalAmount <> '' AND A.AccountCode <> 'jianshe'
and c.SD_DesignContent = '2' and a.projstatus = '10' and a.CREATETIME >= '2023-01-01' and a.CREATETIME < '2023-07-01'
GROUP BY A.ProjName, B.PG_TotalAmount, A.AccountName, c.SD_SurveyDesignUnitName, f.UnitProvince, f.UnitCity, f.UnitDistrict, f.UnitAddress, d.CI_ReviewUnitName, h.RegisterProvince, h.RegisterCity, h.RegisterDistrict, h.RegisterAddress, f.ID, i.PictureNumber, j.PictureNumber


--加了对变更的过滤

--(2023.1-6.30已办结项目)
--项目名称、总投资额、建设单位、设计单位、设计单位注册地址、设计单位资质等级、设计合同费用、图审单位、图审单位注册地址、图审合同费用。
--如果存在重大变更情况，以最后一次变更为主
WITH ProjDoc_CTE AS (
    SELECT MainID, CREATEBY, ListID, PictureNumber,
    ROW_NUMBER() OVER(PARTITION BY MainID, CREATEBY, ListID ORDER BY PictureNumber) AS rn
    FROM T_HN_ProjDoc
)
SELECT distinct  A.ProjName as 项目名称,B.PG_TotalAmount as '总投资额(万元)',A.AccountName as 建设单位,c.SD_SurveyDesignUnitName as 设计单位,
(f.UnitProvince+f.UnitCity+ f.UnitDistrict + f.UnitAddress) as 设计单位注册地址,
STUFF((SELECT ', ' + CASE 
  WHEN g.EQ_QualificationLevel = '1' THEN '甲级'
  WHEN g.EQ_QualificationLevel = '2' THEN '乙级'
  WHEN g.EQ_QualificationLevel = '3' THEN '丙级'
  WHEN g.EQ_QualificationLevel = '4' THEN '丁级'
  WHEN g.EQ_QualificationLevel = '5' THEN '不分等级'
  ELSE g.EQ_QualificationLevel
END
FROM T_HN_DesignEnterpriseInfo_QLevel g 
WHERE f.ID = g.mainid
FOR XML PATH('')), 1, 2, '') as 设计单位资质等级,
i.PictureNumber as 设计合同费用, d.CI_ReviewUnitName as 图审单位, (h.RegisterProvince+h.RegisterCity+ h.RegisterDistrict + h.RegisterAddress) as 图审单位注册地址,j.PictureNumber as 图审合同费用
FROM t_hn_mAIN A
LEFT JOIN  T_HN_Main_ProjGeneralInfo  B ON A.ID = B.MainID
left join T_HN_Main_SurveyDesignUnit c on a.ID = c.MainID
left join T_HN_Main_CensorshipInfo d on a.ID = d.MainID
left join T_HN_DesignEnterpriseInfo f on c.SD_UnitCode = f.User_Name
left join T_HN_DesignEnterpriseInfo_QLevel g on f.ID = g.mainid
left join T_HN_ReviewEnterpriseInfo h on d.CI_UnitCode = h.User_Name
left join ProjDoc_CTE i on a.id = i.MainID and i.CREATEBY = c.SD_UnitCode and i.ListID = '30' and i.rn = 1
left join ProjDoc_CTE j on a.id = j.MainID and j.CREATEBY = d.CI_UnitCode  and j.ListID = '30' and j.rn = 1
WHERE B.PG_TotalAmount IS NOT NULL 
AND B.PG_TotalAmount <> '' 
AND A.AccountCode <> 'jianshe'
and c.SD_DesignContent = '2' 
and a.projstatus = '10' 
and a.CREATETIME >= '2023-01-01' 
and a.CREATETIME < '2023-07-01'
AND A.id <> ISNULL(A.preid, 0) -- 添加这一条来排除满足条件的数据
GROUP BY  A.ProjName, B.PG_TotalAmount, A.AccountName, c.SD_SurveyDesignUnitName, f.UnitProvince, f.UnitCity, f.UnitDistrict, f.UnitAddress, d.CI_ReviewUnitName, h.RegisterProvince, h.RegisterCity, h.RegisterDistrict, h.RegisterAddress, f.ID, i.PictureNumber, j.PictureNumber

---杨翰让导出数据：2022年12月以来，1、市政项目中工程类型为：道路工程的项目，2、居住建筑面积 5000平以上的项目。以上两点：均为已办结的施工图审查项目，导出字段为：项目名称、建设单位、设计单位、图审单位、项目办结时间。
SELECT * FROM T_HN_Main_ProjGeneralInfo
WHERE PG_ProjType = '2' AND PG_ConType = '道路工程'
AND MainID IN (SELECT ID FROM T_HN_Main WHERE ProjStatus = '10')
AND MainID IN (SELECT MainID FROM T_HN_Main_BuildingInfo WHERE TRY_CAST(BI_BuildingArea AS float) >= 5000)


SELECT A.ProjName AS  项目名称, A.AccountName AS 建设单位,c.SD_SurveyDesignUnitName as 设计单位,d.CI_ReviewUnitName as 图审单位,A.UPDATETIME AS 项目办结时间  FROM t_hn_mAIN A
left join T_HN_Main_SurveyDesignUnit c on a.ID = c.MainID
left join T_HN_Main_CensorshipInfo d on a.ID = d.MainID
WHERE A.ID IN ('5a60a52fc3cafc388afb3a0da8d5d445','fe857813588f587e6cfa3a0d4e0a077a')



SELECT
  DISTINCT A.ProjName AS 项目名称,
  A.ProjCode AS ProjCode,
  A.AccountName AS 建设单位,
  STUFF((SELECT ',' + SD_SurveyDesignUnitName
         FROM T_HN_Main_SurveyDesignUnit
         WHERE MainID = A.ID
         FOR XML PATH('')), 1, 1, '') AS 设计单位,
  d.CI_ReviewUnitName as 图审单位,
  A.UPDATETIME AS 项目办结时间
FROM t_hn_mAIN A
LEFT JOIN T_HN_Main_SurveyDesignUnit c ON a.ID = c.MainID
LEFT JOIN T_HN_Main_CensorshipInfo d ON a.ID = d.MainID
WHERE A.ID IN (SELECT MainID FROM T_HN_Main_ProjGeneralInfo
WHERE  A.AccountCode <> 'jianshe' and PG_ProjType = '2' AND (PG_ConType = '道路工程' or PG_ConType = '城市道路')
AND MainID IN (SELECT ID FROM T_HN_Main WHERE ProjStatus = '10') and d.CI_ReviewContent = '2'
--AND MainID IN (SELECT MainID FROM T_HN_Main_BuildingInfo WHERE TRY_CAST(BI_BuildingArea AS float) >= 5000)
AND MAINID IN (SELECT MAINID FROM WF_Instance  WHERE  WF_Code =  'WF_0013')
)  order by ProjCode

--王博要求的查询
SELECT  ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS 序号,*,
DATEDIFF(HOUR, 建设单位第一次送审节点开始时间, 图审机构第三次出具意见办结时间) as 第11列第6列时间差,
DATEDIFF(HOUR, 建设单位第一次送审节点开始时间, 图审机构第一次出具意见办结时间) as 第7列第6列时间差,
DATEDIFF(HOUR, 图审机构第一次出具意见办结时间, 建设单位第二次送审节点开始时间) as 第8列第7列时间差,
DATEDIFF(HOUR, 建设单位第二次送审节点开始时间, 图审机构第二次出具意见办结时间) as 第9列第8列时间差,
DATEDIFF(HOUR, 图审机构第二次出具意见办结时间, 建设单位第三次送审节点开始时间) as 第10列第9列时间差,
DATEDIFF(HOUR, 建设单位第三次送审节点开始时间, 图审机构第三次出具意见办结时间) as 第11列第10列时间差
FROM 
(
    SELECT 
   
        a.ProjName as 项目名称,
        a.ProjCode as 项目代码,
        CASE 
            WHEN b.PG_DesignScale = '1' THEN '小型'
            WHEN b.PG_DesignScale = '2' THEN '中型'
            WHEN b.PG_DesignScale = '3' THEN '大型'
            ELSE b.PG_DesignScale
        END   as 工程规模,
        b.PG_ConType as 工程类型 ,
        建设单位第一次送审节点开始时间 = (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00002' 
    ) as mm where mm.RowNumber = '1'),
        图审机构第一次出具意见办结时间 = (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064' 
    ) as mm where mm.RowNumber = '1'),
        建设单位第二次送审节点开始时间 = (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00002' and aa.CREATETIME > (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064' 
    ) as mm where mm.RowNumber = '1') and aa.CREATETIME < (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064' 
    ) as mm where mm.RowNumber = '2')
    ) as mm where mm.RowNumber = '1'),
        图审机构第二次出具意见办结时间 = (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064' 
    ) as mm where mm.RowNumber = '2'),
        建设单位第三次送审节点开始时间 = (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00002'  and aa.CREATETIME > (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064' 
    ) as mm where mm.RowNumber = '2') and aa.CREATETIME < (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064' 
    ) as mm where mm.RowNumber = '3')
    ) as mm where mm.RowNumber = '1'),
        图审机构第三次出具意见办结时间 = (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064' 
    ) as mm where mm.RowNumber = '3')
    FROM 
        t_hn_MAIN a
    LEFT JOIN 
        T_HN_Main_ProjGeneralInfo b ON a.id = b.MainID
    left join WF_Instance c on a.id = c.MainId
    WHERE 
        a.ProjStatus = '10' 
        AND a.AccountCode <> 'jianshe' 
        AND a.BusinessType = '0'
        and c.WF_Code = 'WF_0013'  and c.Status = '10'
) as subquery

--21. 三个单位的表
select * from T_HN_BuildEnterpriseInfo

select * from T_HN_DesignEnterpriseInfo

select * from T_HN_ReviewEnterpriseInfo


--22 修复accountName历史数据
-- 第一次更新：用 T_HN_EnterpriseUser 表的 CompanyName 更新 T_HN_Main 表
UPDATE M
SET M.accountName = E.CompanyName
FROM T_HN_Main M
INNER JOIN T_HN_EnterpriseUser E ON M.UnitCode = E.User_Name
WHERE M.accountName = '建设单位' 
AND M.UnitCode <> 'jianshe' 
AND M.UnitCode <> ''

-- 第二次更新：用 T_HN_PersonalUser 表的 RegistrantName 更新 T_HN_Main 表
UPDATE M
SET M.accountName = P.RegistrantName
FROM T_HN_Main M
INNER JOIN T_HN_PersonalUser P ON M.UnitCode = P.UserName
WHERE M.accountName = '建设单位' 
AND M.UnitCode <> 'jianshe' 
AND M.UnitCode <> ''

--23  修复校对等流程丢失需要插入task表的问题
INSERT INTO WF_Task
VALUES
(REPLACE(NEWID(), '-', ''), 'dca4ba525fe2945f80f63a0b83b7b88e', '485ec1a2ba73d1dc79fb3a0b9bb4d5d0', '460002198907151814', '59b9a7bd56e32567e30239fe9272ee48', '0', '2023-06-05 11:09:30.961', '460026197607200051', NULL, NULL, '1');

GO

 UPDATE WF_Task SET UserOrRoleId = '460024198008242016',Status = '1',WfStepDefinitionId = '44a5b83de0fcb031967339fff5e534a8' WHERE ID = '7e24783c7cb832a5fde23a0b9bb4d5d0'

 --24  查询图审单位没有上传合同的数据
 select * from T_HN_main where CREATETIME >= '2023-03-01' and ProjStatus = '10' AND ID NOT IN (

SELECT A.MainID FROM T_HN_Main_CensorshipInfo A
INNER JOIN t_hn_mAIN B ON A.MainID = B.ID 
INNER JOIN T_HN_ProjDoc C ON C.MainID = A.MainID AND C.CREATEBY = A.CI_UnitCode
WHERE  B.ProjStatus = '10' AND  C.ListID = '30')

--25   查询审查人员相关信息
select a.RegistrantName 名字,b.UnitName 单位,case b.Major
WHEN '0' THEN '工程勘察'
    WHEN '1' THEN '建筑'
    WHEN '2' THEN '结构'
    WHEN '3' THEN '给排水'
    WHEN '4' THEN '暖通'
    WHEN '5' THEN '电气'
    WHEN '6' THEN '其他'
    WHEN '7' THEN '道路'
    WHEN '8' THEN '桥梁'
    WHEN '9' THEN '园林'
    ELSE '其他'
END AS 专业,
case a.AuditStatus
when '0' then '游客'
when '1' then '企业审核中'
when '11' then '政府主管部门审核中'
when '2' then '审核通过'
when '3' then '已驳回'
else '游客' end  as 状态
,a.UPDATETIME 最后一次提交审核时间 from T_HN_PersonalUser a
left join  T_HN_PersonalInformation b on a.username = b.UserName and a.UserType = b.UnitType
where usertype = '4'

GO
--图审编码对应关系

update T_HN_CompanyMapInfo set CompanyCode = '91460100721230885P'  where CompanyName = '海口市城建建设工程施工图设计文件审查有限公司'
GO
update T_HN_CompanyMapInfo set CompanyCode = '91460200730046086C'  where CompanyName = '三亚市建协施工图设计审查有限公司'
GO
update T_HN_CompanyMapInfo set CompanyCode = '91460000730061622W'  where CompanyName = '雅克设计有限公司（雅克设计有限公司审图中心）'
GO
update T_HN_CompanyMapInfo set CompanyCode = '91460000901260571X'  where CompanyName = '海南华磊建筑设计咨询有限公司（华磊建设工程施工图设计文件审查服务中心）'
GO
update T_HN_CompanyMapInfo set CompanyCode = '91460100201325792U'  where CompanyName = '海口市城市规划设计研究院有限公司（海口市城市规划设计研究院有限公司施工图审查中心）'
GO
update T_HN_CompanyMapInfo set CompanyCode = '914600002012595969'  where CompanyName = '海南华筑国际工程设计咨询管理有限公司（海南华筑图审中心）'
GO
update T_HN_CompanyMapInfo set CompanyCode = ''  where CompanyName = '海口市市政工程设计研究院（海口市市政工程设计研究院图审中心）'
GO
update T_HN_CompanyMapInfo set CompanyCode = '91460000721250018N'  where CompanyName = '海南元正建筑设计咨询有限责任公司施工图审查服务中心'
GO
update T_HN_CompanyMapInfo set CompanyCode = '91460000747797513B'  where CompanyName = '海南佳风工程设计有限公司（海南佳风市政基础设施工程施工图审查中心）'
GO

select * from T_HN_EnterpriseUser  where CompanyName like '%海口市市政工程设计研究院%'

--登录信息查看
--企业
SELECT * FROM SYS_lOG   WHERE LOG_TYPE = '1'
AND USERID IN (SELECT USERNAME FROM T_HN_PersonalUser  where RoleName = 'ZG')
AND  CREATETIME >= '2023/09/12'
--zg
SELECT * FROM SYS_lOG   WHERE LOG_TYPE = '1'
AND USERID IN (SELECT USERNAME FROM T_HN_PersonalUser  where RoleName = 'ZG')
AND  CREATETIME >= '2023/09/12'

--1、绿色建筑项目统计，2023年1月1号开始，统计字段为：项目编号、项目名称、项目地址、工程类型、绿色建筑面积。
-- 2、绿色建筑单体星级明细统计，2023年1月1号开始，单体中勾选了绿色建筑及星级选项，统计字段为：项目编号、项目名称、
-- 项目地址、工程类型、单体名称、是否为绿色建筑、绿色建筑目标标准等级、绿色建筑面积(m2)。

select distinct a.ProjCode as 项目编号,a.ProjName as 项目名称,(d.PI_Province + d.PI_City + d.PI_Address) as 项目地址,
case c.PG_ProjType  when '1' then '房屋建筑工程' when '2' then  '市政基础设施工程' else '其他' end    AS  项目类型,b.BI_GreenBuildingArea as 绿色建筑面积 from T_HN_Main a
inner join T_HN_Main_BuildingInfo b on  a.id = b.MainID
left join T_HN_Main_ProjGeneralInfo  c on a.ID = c.MainID
left join T_HN_Main_ProjInfo  d on a.ID = d.MainID
inner join WF_Instance  f on a.ID = f.MainId
where BI_IsHaveGreenBuilding = '1' and isnull(a.DeletionStateCode,'0') <> '1' and AccountCode <> 'jianshe' and a.ProjStatus = '10' and a.CREATETIME > = '2023/01/01'
and f.WF_Code in ('WF_0013', 'WF_0015' , 'WF_0016') and f.Status = '10'and f.FatherId is null

select distinct a.ProjCode as 项目编号,a.ProjName as 项目名称,(d.PI_Province + d.PI_City + d.PI_Address) as 项目地址,
case c.PG_ProjType  when '1' then '房屋建筑工程' when '2' then  '市政基础设施工程' else '其他' end    AS  项目类型,b.BS_BuildingName,
case JSON_VALUE(CAST(b.BS_BuildingJson AS nvarchar(max)), '$.GreenBuildingGrade') when '0' then '基本级'  when '1' then '一星'   when '2' then '二星'  when '3' then '三星'   end '其他'  as 绿色建筑目标标准等级,
JSON_VALUE(CAST(b.BS_BuildingJson AS nvarchar(max)), '$.GreenBuildingArea') as 绿色建筑面积
from T_HN_Main_SingleBidSection   b
left join T_HN_Main a on b.MainID = a.ID
left join T_HN_Main_ProjGeneralInfo  c on a.ID = c.MainID
left join T_HN_Main_ProjInfo  d on a.ID = d.MainID
where b.BS_BuildingJson  like '%GreenBuildingGrade%'   and isnull(a.DeletionStateCode,'0') <> '1' and AccountCode <> 'jianshe' and a.CREATETIME > = '2023/01/01'
and  JSON_VALUE(CAST(b.BS_BuildingJson AS nvarchar(max)), '$.GreenBuildingGrade') <> '' and  JSON_VALUE(CAST(b.BS_BuildingJson AS nvarchar(max)), '$.GreenBuildingGrade') is not null
and JSON_VALUE(CAST(b.BS_BuildingJson AS nvarchar(max)), '$.IsHaveGreenBuilding')  = '1'
and b.MainID  in (select a.id from T_HN_Main a
inner join T_HN_Main_BuildingInfo b on  a.id = b.MainID
left join T_HN_Main_ProjGeneralInfo  c on a.ID = c.MainID
left join T_HN_Main_ProjInfo  d on a.ID = d.MainID
inner join WF_Instance  f on a.ID = f.MainId
where BI_IsHaveGreenBuilding = '1' and isnull(a.DeletionStateCode,'0') <> '1' and AccountCode <> 'jianshe' and a.ProjStatus = '10' and a.CREATETIME > = '2023/01/01'
and f.WF_Code in ('WF_0013', 'WF_0015' , 'WF_0016') and f.Status = '10'and f.FatherId is null )


--查询所有办结项目（施工图、勘察）分成两个表，项目各节点时间信息。
--查询字段：项目编号、项目名称、工程类别、工程规模、勘察等级、项目建设单位发起设计上传（已办结时间节点）、
-- 设计单位企业签章确认办结时间（已办结时间节点）、建设单位确认送审时间（已办结时间节点）、一审办结时间（已办结时间节点）、
-- 二审建设单位发起设计上传（已办结时间节点）、二审设计单位企业签章确认办结时间（已办结时间节点）、
-- 建设单位确认送审时间（已办结时间节点）、二审办结时间（已办结时间节点）。


SELECT   distinct *

FROM
(
    SELECT
        a.ProjCode as 项目编码,
        a.ProjName as 项目名称,
        CASE
            WHEN b.PG_ConType = '1' THEN '房建'
            WHEN b.PG_ConType = '2' THEN '市政'
            WHEN b.PG_ConType = '3' THEN '消防'
            ELSE b.PG_ConType
        END   as 工程类别,
        CASE
            WHEN b.PG_DesignScale = '1' THEN '小型'
            WHEN b.PG_DesignScale = '2' THEN '中型'
            WHEN b.PG_DesignScale = '3' THEN '大型'
            ELSE b.PG_DesignScale
        END   as 工程规模,
        CASE
            WHEN b.PG_SurveyLevel = '2' THEN '一级工程'
            WHEN b.PG_SurveyLevel = '3' THEN '二级工程'
            WHEN b.PG_SurveyLevel = '4' THEN '三级工程'
            ELSE '无'
        END   as 勘察等级,
        b.PG_ConType as 工程类型 ,
        一审项目建设单位发起设计上传 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME desc ) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00002' and aa.Action = 'Proceed'
    and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    ) as mm where mm.RowNumber = '1'),
        一审设计单位企业签章确认办结时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime desc ) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00063'  and aa.Action = 'Proceed'
     and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    ) as mm where mm.RowNumber = '1'),
        一审建设单位确认送审时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime desc ) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00007'  and aa.Action = 'Proceed'
    and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    ) as mm where mm.RowNumber = '1'),
        一审技术负责人分配通过时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime desc) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00009'  and aa.Action = 'Proceed'
     and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    ) as mm where mm.RowNumber = '1'),
        一审政策性审查通过时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00010'  and aa.Action = 'Proceed'
    and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    ) as mm where mm.RowNumber = '1'),
        一审办结时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'),

         二审项目建设单位发起设计上传 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME DESC ) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00002'  and aa.Action = 'Proceed'
    and aa.SubmitTime > ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '2'))

    ) as mm where mm.RowNumber = '1'),
        二审设计单位企业签章确认办结时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime DESC ) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00063'  and aa.Action = 'Proceed'
  and aa.SubmitTime > ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '2'))

    ) as mm where mm.RowNumber = '1'),
        二审建设单位确认送审时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime DESC ) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00007'  and aa.Action = 'Proceed'
    and aa.SubmitTime > ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '2'))

    ) as mm where mm.RowNumber = '1'),
        二审技术负责人分配通过时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime DESC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00009'  and aa.Action = 'Proceed'
    and aa.SubmitTime > ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '2'))

    ) as mm where mm.RowNumber = '1'),
        二审政策性审查通过时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime DESC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00010'  and aa.Action = 'Proceed'
    and aa.SubmitTime > ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '1'))
    and aa.SubmitTime < ((select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'
    ) as mm where mm.RowNumber = '2'))

    ) as mm where mm.RowNumber = '1'),
        二审办结时间 = (select SubmitTime from  (select  ROW_NUMBER() OVER (ORDER BY aa.SubmitTime ASC) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_00064'

    ) as mm where mm.RowNumber = '2'),
         流程结束时间 = (select CREATETIME from  (select  ROW_NUMBER() OVER (ORDER BY aa.CREATETIME DESC ) AS RowNumber,* from WF_Instance_RunningRecord aa where aa.InstanceId  =c.id
    and aa.StepCode = 'STEP_99999'
    ) as mm where mm.RowNumber = '1')



    FROM
        t_hn_MAIN a
    LEFT JOIN
        T_HN_Main_ProjGeneralInfo b ON a.id = b.MainID
    left join WF_Instance c on a.id = c.MainId
    WHERE

         a.AccountCode <> 'jianshe'
        AND a.BusinessType = '0'
        and c.WF_Code = 'WF_0013'  and c.Status = '10' and c.FatherId is null and isnull(a.DeletionStateCode,0) <> '1'
) as subquery where subquery.一审办结时间 is not null


