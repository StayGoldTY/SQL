GO
drop table  SpaceDb.dbo.T_HNMap_ProjInfo
GO
select distinct 
newid() as ID,
a.prjid as ProjCode,
a.prjName as ProjName,
a.szsx as CityCode,
a.dispszqx as CityName,
case  when isNull(max(b.gczt),'未上报') = '待上报' then 1  
when isNull(max(b.gczt),'未上报') = '未上报' then 2
when isNull(max(b.gczt),'未上报') = '已上报' then 3 
when isNull(max(b.gczt),'未上报') = '审批通过' then 4
when isNull(max(b.gczt),'未上报') = '审核退回' then 5
else 2 end   ProjStatus,
sum(a.zjzmj) as ProjAreas,
0 as  ProjBuildingNum ,
case when isnull(sum(b.bzxzfmj),0)  >0 then 1 else 0 end IsSocialHousingProj,
case when max(b.ynzps) = '是' then 1 else 0 end IsAssembledProj,
case when isnull(max(b.sghtje),0) <= 2500 then 1 
when  isnull(max(b.sghtje),0) <= 5000 then 2  
when  isnull(max(b.sghtje),0) <= 20000 then 3 
when  isnull(max(b.sghtje),0)<= 50000 then 4 
when  isnull(max(b.sghtje),0) <= 100000 then 5 
else 6 end ProjScale,
case when sum(CAST( b.jzgm as float))  >0 then 1 else 0 end IsBuildingProj,
case when CHARINDEX('市政',a.prjtype) > 0 then 1 else 0 end IsCivilProj,
count(d.sgxkzh) as CheckStatistics,
'' as PositionInfo,
1 as IsSync,
CONVERT(varchar,GETDATE(),120) as CREATETIME,
'space' as CREATEBY,
'' as UpdateTime,
'' as UPDATEBY,
0 as DeletionStateCode
 into  SpaceDb.dbo.T_HNMap_ProjInfo
from middledblink.hainjwdb.dbo.T_P_PrjBaseInfo a
left join middledblink.hainjwdb.dbo.T_P_zjgc_sgtxkzsdj b on a.prjid = b.prjid AND a.prjcode = b.PrjCode
left join middledblink.hainjwdb.dbo.T_P_zjgc_sgtxkzsxx c on b.bdbh = c.bdbh
left join jdxtdblink.hainan_jddata.dbo.view_jdcc_itm d on c.sgxkzbh = d.sgxkzh
group by a.prjid,a.prjName,a.szsx,a.dispszqx,a.prjtype

