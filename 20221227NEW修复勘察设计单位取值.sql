-- =============================================                  
-- Author:  gongxiaoyong                  
-- Create date: 2021-06-03                  
-- Description: 获取审查合格书表单 b6ff6b6a-0b5f-432c-b694-3a9152fc6200                  
-- =============================================                  
ALTER PROCEDURE [dbo].[usp_Censorship_GetFormData]                   
 -- Add the parameters for the stored procedure here                  
 @Type VARCHAR(10),                  
 @ID VARCHAR(50)                  
AS                  
BEGIN                  
 -- SET NOCOUNT ON added to prevent extra result sets from                  
 -- interfering with SELECT statements.                  
 SET NOCOUNT ON;                  
                  
  DECLARE @No    NVARCHAR(200);      
  set @No = (SELECT DISTINCT TOP 1                   
  isnull(c.CompanyCertificateCode,'琼Z')+ '-' + RIGHT(a.ProjCode,'6') + '-1-' + DateName(year,GetDate())                        
  FROM T_HN_Main a                            
  LEFT JOIN T_HN_Main_CensorshipInfo b ON a.ID = b.mainid          
  left join T_HN_CompanyMapInfo  c on b.CI_UnitCode = c.CompanyCode             
  WHERE a.ID = @ID  )               
                   
 IF @type = '1'                  
 begin                   
  SELECT DISTINCT TOP 1                   
   @No AS [No],                  
   ISNULL(c.CI_ReviewUnitName,'') AS CI_ReviewUnitName,                  
   CONVERT(varchar( 100 ), GETDATE(), 23 ) AS DataTime ,                 
   ISNULL(a.ProjName,'') AS ProjName,                   
   (b.PI_City + b.PI_District + b.PI_ConstructionSite )AS [Address] ,                  
   ISNULL(l.CompanyName,'') AS UnitName,                  
   ISNULL(d.SD_SurveyDesignUnitName,'') AS  SD_SurveyDesignUnitName,                   
   CertificateNo = ISNULL(stuff(( select ee.EQ_CertificateNo     + ';'                   
         FROM T_HN_DesignEnterpriseInfo cc                   
         INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.SocialCreditCode = dd.SD_UnitCode   and IsNull(dd.SD_IsMainDesign,-1) <> '0'                
         LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid                   
         WHERE CHARINDEX(ee.EQ_QualificationCategory,'勘察') > 0 AND dd.mainid = @ID FOR XML path('') ), 1, 1, ''),'0'),                   
   ISNULL(g.PG_SurveyLevel,'')  AS PG_SurveyLevel,                  
   ISNULL(e.GeotechnicalEngineerName,'') AS  GeotechnicalEngineerName,                   
   ISNULL(b.PI_Director,'') AS PI_Director,                  
   ISNULL(g.PG_MainConstructionContent,'') AS PG_MainConstructionContent,                  
    ProjManagerID = (SELECT b.RegistrantName + ';'  FROM T_HN_TaskStaff a 
LEFT JOIN T_HN_PersonalUser b on a.UserID = b.username
WHERE a.MAINID = @ID AND a.ReviewType = '2'
GROUP BY a.USERID,b.RegistrantName
FOR XML path('')),                  
   ISNULL(m.RegistrantName,'') AS CTO,                    
   ISNULL(i.LegalName,'')  AS LegalName                  
  FROM T_HN_Main a                   
  LEFT JOIN T_HN_Main_ProjInfo b ON a.ID = b.mainid                   
  LEFT JOIN T_HN_Main_CensorshipInfo C ON a.ID = c.mainid                   
  inner JOIN T_HN_Main_SurveyDesignUnit d ON a.ID = d.mainid AND c.CI_WorkInstancesID = d.SD_WorkInstancesID AND d.SD_DesignContent = '1'   and IsNull(d.SD_IsMainDesign,-1) <> '0'                 
  LEFT JOIN T_HN_DesignEnterpriseInfo e ON d.SD_UnitCode = e.User_Name                   
  LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel f ON e.ID = f.mainid                   
  LEFT JOIN T_HN_Main_ProjGeneralInfo g ON a.ID = g.mainid                   
  LEFT JOIN (select MainID,MAX(ProjManagerID)AS ProjManagerID                  
     from T_HN_ProjectManager where SetStage = '2' group by MainID) as h ON a.ID = h.MainID                     
  LEFT JOIN T_HN_ReviewEnterpriseInfo i ON c.CI_UnitCode = i.User_Name         
  left join T_HN_EnterpriseUser l on a.UnitName = l.User_Name  
  LEFT JOIN T_HN_PersonalUser m on h.ProjManagerID = m.username  
  WHERE a.ID = @ID                   
 END                   
                   
 IF @type = '2'                   
 begin                   
  SELECT DISTINCT TOP 1                   
   @No AS [No],                  
   ISNULL(c.CI_ReviewUnitName,'') AS CI_ReviewUnitName,                  
   CONVERT(varchar( 100 ), GETDATE(), 23 ) AS DataTime ,                
   ISNULL(a.ProjName,'') AS ProjName,                  
   (b.PI_City + b.PI_District + b.PI_ConstructionSite )AS [Address],         
    CASE b.PI_ProjLevel                   
    WHEN 1 THEN '特级'                  
    WHEN 2 THEN '一级'                  
    WHEN 3 THEN '二级'                   
    ELSE '三级'                   
   END AS ProjGreade ,    
   ISNULL(l.CompanyName,'') AS UnitName,                  
   ISNULL(b.PI_ConPermissionNo,'') AS PI_ConPermissionNo,                   
   SurveyUnitName = ISNULL((SELECT  top 1  bb.SD_SurveyDesignUnitName    + ';'                 
        FROM T_HN_Main aa                   
        LEFT JOIN T_HN_Main_SurveyDesignUnit bb ON aa.ID = bb.mainid                   
        WHERE aa.ID = @ID AND bb.SD_DesignContent = '1'  and IsNull(bb.SD_IsMainDesign,-1) <> '0'),(select top 1 PG_KCUnitName from T_HN_Main_ProjGeneralInfo where MainID = @ID)),                   
   SurveyCertificateNo = ISNULL(stuff(( select ee.EQ_CertificateNo  + ';'                  
           FROM T_HN_DesignEnterpriseInfo cc                   
           INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.SocialCreditCode = dd.SD_UnitCode AND dd.SD_DesignContent = '1'   and IsNull(dd.SD_IsMainDesign,-1) <> '0'                
           LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid                   
           WHERE dd.mainid = @ID FOR XML path('') ), 1, 1, ''),''),                  
   DesignUnitName = ISNULL((SELECT  top 1  bb.SD_SurveyDesignUnitName   + ';'                  
        FROM T_HN_Main aa                   
        LEFT JOIN T_HN_Main_SurveyDesignUnit bb ON aa.ID = bb.mainid                   
    WHERE aa.ID = @ID AND bb.SD_DesignContent = '2'  and IsNull(bb.SD_IsMainDesign,-1) <> '0'),''),                   
   DesignCertificateNo = ISNULL(stuff(( select ee.EQ_CertificateNo  + ';'                   
           FROM T_HN_DesignEnterpriseInfo cc                   
           INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.User_Name = dd.SD_UnitCode AND dd.SD_DesignContent = '2'   and IsNull(dd.SD_IsMainDesign,-1) <> '0'                
           LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid                   
           WHERE  dd.mainid = @ID FOR XML path('') ), 1, 1, ''),''),                   
       CASE PG_DesignScale                   
    WHEN 1 THEN '小型'                   
    WHEN 2 THEN '中型'                   
    WHEN 3 THEN '大型'                        
    else '小型'                   
   end AS PG_DesignScale,        
   j.BI_BuildingHeight as BS_HighOrDeepBuried,                
   case j.BI_StructureSystem     
   WHEN 1 THEN '砌体结构'                   
    WHEN 2 THEN '底框结构'                   
    WHEN 3 THEN '框架结构'                  
    WHEN 4 THEN '框架-剪力墙结构'                  
    WHEN 5 THEN '剪力墙结构'                  
    WHEN 6 THEN '板柱-剪力墙结构'       
 WHEN 7 THEN '短肢墙剪力墙结构'                   
    WHEN 8 THEN '部分框支剪力墙结构'                   
    WHEN 9 THEN '框-简体结构'                  
    WHEN 10 THEN '简中简结构'                  
    WHEN 11 THEN '异型柱框结构'                  
    WHEN 12 THEN '复杂高层结构'     
 WHEN 13 THEN '混合结构'                   
    WHEN 14 THEN '钢结构'                   
    WHEN 15 THEN '排架结构'                             
    else '其他'                   
   end AS BS_StructureType,                
   CASE b.PI_ConstructionNature                   
    WHEN 1 THEN '新建'                   
    WHEN 2 THEN '改建'                   
    WHEN 3 THEN '扩建'                  
    WHEN 4 THEN '恢复'                  
    WHEN 5 THEN '迁建'                  
    WHEN 6 THEN '拆除'                  
    else '其他'                   
   end AS ConstructionNature,                    
   ISNULL(j.BI_AbovegroundLayerNum,'') AS BS_AbovegroundFloors ,                  
   ISNULL(j.BI_UndergroundLayerNum,'') AS BS_UndergroundFloors,                  
   ISNULL(j.BI_BuildingArea,'') AS BI_BuildingArea,                  
   ISNULL(j.BI_AbovegroundArea,'') AS BI_AbovegroundArea ,                  
   ISNULL(j.BI_UndergroundArea,'') AS BI_UndergroundArea,                  
   ISNULL(j.BI_GreenBuildingArea,'') AS BI_GreenBuildingArea,                  
   ISNULL(j.BI_AssemblyArea,'') AS BI_AssemblyArea,                  
   ISNULL(j.BI_SolarApplicationArea,'') AS BI_SolarApplicationArea,                  
   ISNULL(j.BI_CollectorArea,'') AS BI_CollectorArea,                   
   ISNULL(j.BI_SolarCapacity,'') AS BI_SolarCapacity,                  
   0 AS  RenewableEnergy,                  
   ISNULL(j.BI_IsAssemblyBuilding,0) AS BI_IsAssemblyBuilding,                  
   ISNULL(j.BI_IsHaveGreenBuilding,0) AS BI_IsHaveGreenBuilding,                   
   a.ReviewContent,                                
    ProjManagerID = (SELECT b.RegistrantName + ';'  FROM T_HN_TaskStaff a 
LEFT JOIN T_HN_PersonalUser b on a.UserID = b.username
WHERE a.MAINID = @ID AND a.ReviewType = '2'
GROUP BY a.USERID,b.RegistrantName
FOR XML path('')),                  
   ISNULL(m.RegistrantName,'') AS CTO,                  
   ISNULL(i.LegalName,'') AS LegalName                  
  FROM T_HN_Main a                   
  LEFT JOIN T_HN_Main_ProjInfo b ON a.ID = b.mainid                   
  LEFT JOIN T_HN_Main_CensorshipInfo C ON a.ID = c.mainid                   
  LEFT JOIN T_HN_Main_SurveyDesignUnit d ON a.ID = d.mainid AND c.CI_WorkInstancesID = d.SD_WorkInstancesID   and IsNull(d.SD_IsMainDesign,-1) <> '0'                
  LEFT JOIN T_HN_DesignEnterpriseInfo e ON d.SD_UnitCode = e.User_Name                  
  LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel f ON e.ID = f.mainid                  
  LEFT JOIN T_HN_Main_ProjGeneralInfo g ON a.ID = g.mainid                   
  LEFT JOIN (select MainID,MAX(ProjManagerID)AS ProjManagerID                  
     from T_HN_ProjectManager where SetStage = '2' group by MainID) as h ON a.ID = h.MainID                
  LEFT JOIN T_HN_ReviewEnterpriseInfo i ON c.CI_UnitCode = i.USER_NAME                   
  LEFT JOIN T_HN_Main_BuildingInfo j ON a.ID = j.mainid    
  left join T_HN_EnterpriseUser l on a.UnitName = l.User_Name  
  LEFT JOIN T_HN_PersonalUser m on h.ProjManagerID = m.username  
  WHERE a.ID = @ID               
 end                   
                   
 IF @type = '3'                   
 begin                   
  SELECT DISTINCT TOP 1                   
   @No AS [No],                  
   ISNULL(c.CI_ReviewUnitName,'') AS CI_ReviewUnitName ,                  
   CONVERT(varchar( 100 ), GETDATE(), 23 ) AS DataTime ,              
   ISNULL(a.ProjName,'') AS ProjName,                   
   (b.PI_City + b.PI_District + b.PI_ConstructionSite )AS [Address],                   
   CASE b.PI_ProjLevel                   
    WHEN 1 THEN '特级'                  
    WHEN 2 THEN '一级'                  
    WHEN 3 THEN '二级'                   
    ELSE '三级'                   
   END AS ProjGreade ,                
   ISNULL(l.CompanyName,'') AS UnitName,                
   ISNULL(b.PI_ConPermissionNo,'') AS PI_ConPermissionNo,                   
   SurveyUnitName = ISNULL((SELECT   top 1 bb.SD_SurveyDesignUnitName    + ';'                    
        FROM T_HN_Main aa                   
        LEFT JOIN T_HN_Main_SurveyDesignUnit bb ON aa.ID = bb.mainid                   
        WHERE aa.ID = @ID AND bb.SD_DesignContent = '1' and IsNull(bb.SD_IsMainDesign,-1) <> '0'),''),                  
   SurveyCertificateNo = ISNULL(stuff(( select  top 1 ee.EQ_CertificateNo   + ';'                      
         FROM T_HN_DesignEnterpriseInfo cc                   
        INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.SocialCreditCode = dd.SD_UnitCode AND dd.SD_DesignContent = '1'   and IsNull(dd.SD_IsMainDesign,-1) <> '0'                
         LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid                   
         WHERE CHARINDEX(ee.EQ_QualificationCategory,'勘察') > 0 AND dd.mainid = @ID FOR XML path('') ), 1, 1, ''),''),                  
   DesignUnitName = ISNULL((SELECT  top 1    bb.SD_SurveyDesignUnitName   + ';'                    
        FROM T_HN_Main aa                  
        LEFT JOIN T_HN_Main_SurveyDesignUnit bb ON aa.ID = bb.mainid                   
        WHERE aa.ID = @ID AND bb.SD_DesignContent = '2'),''),                   
  DesignCertificateNo = ISNULL(stuff(( select  top 1 ee.EQ_CertificateNo    + ';'                   
         FROM T_HN_DesignEnterpriseInfo cc                   
         INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.User_Name = dd.SD_UnitCode AND dd.SD_DesignContent = '2'  and IsNull(d.SD_IsMainDesign,-1) <> '0'                
         LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid                   
         WHERE CHARINDEX(ee.EQ_QualificationCategory,'勘察') > 0 AND dd.mainid = @ID FOR XML path('') ), 1, 1, ''),'') ,                   
   ISNULL(g.PG_MainConstructionContent,'') AS PG_MainConstructionContent,                   
    ProjManagerID = (SELECT b.RegistrantName + ';'  FROM T_HN_TaskStaff a 
LEFT JOIN T_HN_PersonalUser b on a.UserID = b.username
WHERE a.MAINID = @ID AND a.ReviewType = '2'
GROUP BY a.USERID,b.RegistrantName
FOR XML path('')),                  
   ISNULL(m.RegistrantName,'') AS CTO,                   
   ISNULL(i.LegalName,'')  AS LegalName                  
  FROM T_HN_Main a                   
  LEFT JOIN T_HN_Main_ProjInfo b ON a.ID = b.mainid                   
  LEFT JOIN T_HN_Main_CensorshipInfo C ON a.ID = c.mainid                   
  LEFT JOIN T_HN_Main_SurveyDesignUnit d ON a.ID = d.mainid AND c.CI_WorkInstancesID = d.SD_WorkInstancesID AND d.SD_DesignContent = '1'  and IsNull(d.SD_IsMainDesign,-1) <> '0'                
  LEFT JOIN T_HN_DesignEnterpriseInfo e ON d.SD_UnitCode = e.User_Name                   
  LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel f ON e.ID = f.mainid                  
  LEFT JOIN T_HN_Main_ProjGeneralInfo g ON a.ID = g.mainid                   
  LEFT JOIN (select MainID,MAX(ProjManagerID)AS ProjManagerID                  
     from T_HN_ProjectManager where SetStage = '2' group by MainID) as h ON a.ID = h.MainID                  
  LEFT JOIN T_HN_ReviewEnterpriseInfo i ON c.CI_UnitCode = i.User_Name       
  left join T_HN_EnterpriseUser l on a.UnitName = l.User_Name  
  LEFT JOIN T_HN_PersonalUser m on h.ProjManagerID = m.username  
  
  WHERE a.ID = @ID                   
 END                  
END 