          
--DROP PROCEDURE [dbo].[usp_Censorship_GetFormData]          
-- =============================================              
-- Author:  gongxiaoyong              
-- Create date: 2021-06-03              
-- Description: ��ȡ���ϸ���� b6ff6b6a-0b5f-432c-b694-3a9152fc6200              
-- =============================================              
Alter PROCEDURE [dbo].[usp_Censorship_GetFormData]               
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
  isnull(c.CompanyCertificateCode,'��Z')+ '-' + RIGHT(a.ProjCode,'6') + '-1-' + DateName(year,GetDate())                    
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
   ISNULL(a.UnitName,'') AS UnitName,              
   ISNULL(d.SD_SurveyDesignUnitName,'') AS  SD_SurveyDesignUnitName,               
   CertificateNo = ISNULL(stuff(( select ee.EQ_CertificateNo               
         FROM T_HN_DesignEnterpriseInfo cc               
         INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.User_Name = dd.SD_UnitCode   and IsNull(dd.SD_IsMainDesign,-1) <> '0'            
         LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid               
         WHERE CHARINDEX(ee.EQ_QualificationCategory,'����') > 0 AND dd.mainid = @ID FOR XML path('') ), 1, 1, ''),'0'),               
   ISNULL(g.PG_SurveyLevel,'')  AS PG_SurveyLevel,              
   ISNULL(e.GeotechnicalEngineerName,'') AS  GeotechnicalEngineerName,               
   ISNULL(b.PI_Director,'') AS PI_Director,              
   ISNULL(g.PG_MainConstructionContent,'') AS PG_MainConstructionContent,              
   ISNULL(h.ProjManagerID,'') AS ProjManagerID,              
   ISNULL(i.CTO,'') AS  CTO,              
   ISNULL(i.LegalName,'')  AS LegalName              
  FROM T_HN_Main a               
  LEFT JOIN T_HN_Main_ProjInfo b ON a.ID = b.mainid               
  LEFT JOIN T_HN_Main_CensorshipInfo C ON a.ID = c.mainid               
  inner JOIN T_HN_Main_SurveyDesignUnit d ON a.ID = d.mainid AND c.CI_WorkInstancesID = d.SD_WorkInstancesID AND d.SD_DesignContent = '1'   and IsNull(d.SD_IsMainDesign,-1) <> '0'             
  LEFT JOIN T_HN_DesignEnterpriseInfo e ON d.SD_UnitCode = e.User_Name               
  LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel f ON e.ID = f.mainid               
  LEFT JOIN T_HN_Main_ProjGeneralInfo g ON a.ID = g.mainid               
  LEFT JOIN (select ProjCode,MAX(ProjManagerID)AS ProjManagerID              
     from T_HN_ProjectManager group by ProjCode)               
     as h ON a.ProjCode = h.ProjCode               
  LEFT JOIN T_HN_ReviewEnterpriseInfo i ON c.CI_UnitCode = i.User_Name               
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
   ISNULL(a.UnitName,'') AS UnitName,              
   ISNULL(b.PI_ConPermissionNo,'') AS PI_ConPermissionNo,               
   SurveyUnitName = ISNULL((SELECT  top 1  bb.SD_SurveyDesignUnitName               
        FROM T_HN_Main aa               
        LEFT JOIN T_HN_Main_SurveyDesignUnit bb ON aa.ID = bb.mainid               
        WHERE aa.ID = @ID AND bb.SD_DesignContent = '1'  and IsNull(bb.SD_IsMainDesign,-1) <> '0'),''),               
   SurveyCertificateNo = ISNULL(stuff(( select ee.EQ_CertificateNo              
           FROM T_HN_DesignEnterpriseInfo cc               
           INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.User_Name = dd.SD_UnitCode AND dd.SD_DesignContent = '1'   and IsNull(dd.SD_IsMainDesign,-1) <> '0'            
           LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid               
           WHERE CHARINDEX(ee.EQ_QualificationCategory,'����') > 0 AND dd.mainid = @ID FOR XML path('') ), 1, 1, ''),'0'),              
   DesignUnitName = ISNULL((SELECT  top 1  bb.SD_SurveyDesignUnitName               
        FROM T_HN_Main aa               
        LEFT JOIN T_HN_Main_SurveyDesignUnit bb ON aa.ID = bb.mainid               
    WHERE aa.ID = @ID AND bb.SD_DesignContent = '2'  and IsNull(bb.SD_IsMainDesign,-1) <> '0'),''),               
   DesignCertificateNo = ISNULL(stuff(( select ee.EQ_CertificateNo               
           FROM T_HN_DesignEnterpriseInfo cc               
           INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.User_Name = dd.SD_UnitCode AND dd.SD_DesignContent = '2'   and IsNull(dd.SD_IsMainDesign,-1) <> '0'            
           LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid               
           WHERE CHARINDEX(ee.EQ_QualificationCategory,'����') > 0 AND dd.mainid = @ID FOR XML path('') ), 1, 1, ''),'0'),               
       CASE PG_DesignScale               
    WHEN 1 THEN 'С��'               
    WHEN 2 THEN '����'               
    WHEN 3 THEN '����'                    
    else 'С��'               
   end AS PG_DesignScale,    
   j.BI_BuildingHeight as BS_HighOrDeepBuried,            
   case j.BI_StructureSystem 
   WHEN 1 THEN '����ṹ'               
    WHEN 2 THEN '�׿�ṹ'               
    WHEN 3 THEN '��ܽṹ'              
    WHEN 4 THEN '���-����ǽ�ṹ'              
    WHEN 5 THEN '����ǽ�ṹ'              
    WHEN 6 THEN '����-����ǽ�ṹ'   
	WHEN 7 THEN '��֫ǽ����ǽ�ṹ'               
    WHEN 8 THEN '���ֿ�֧����ǽ�ṹ'               
    WHEN 9 THEN '��-����ṹ'              
    WHEN 10 THEN '���м�ṹ'              
    WHEN 11 THEN '��������ṹ'              
    WHEN 12 THEN '���Ӹ߲�ṹ' 
	WHEN 13 THEN '��Ͻṹ'               
    WHEN 14 THEN '�ֽṹ'               
    WHEN 15 THEN '�żܽṹ'                         
    else '����'               
   end AS BS_StructureType,            
   CASE b.PI_ConstructionNature               
    WHEN 1 THEN '�½�'               
    WHEN 2 THEN '�Ľ�'               
    WHEN 3 THEN '����'              
    WHEN 4 THEN '�ָ�'              
    WHEN 5 THEN 'Ǩ��'              
    WHEN 6 THEN '���'              
    else '����'               
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
   ISNULL(b.PI_JoinReview,0) AS RF,              
   0 AS LF,              
   1 AS XF,                
   ISNULL(h.ProjManagerID,'')  AS ProjManagerID,              
   ISNULL(i.CTO,'') AS CTO,              
   ISNULL(i.LegalName,'') AS LegalName              
  FROM T_HN_Main a               
  LEFT JOIN T_HN_Main_ProjInfo b ON a.ID = b.mainid               
  LEFT JOIN T_HN_Main_CensorshipInfo C ON a.ID = c.mainid               
  LEFT JOIN T_HN_Main_SurveyDesignUnit d ON a.ID = d.mainid AND c.CI_WorkInstancesID = d.SD_WorkInstancesID   and IsNull(d.SD_IsMainDesign,-1) <> '0'            
  LEFT JOIN T_HN_DesignEnterpriseInfo e ON d.SD_UnitCode = e.User_Name              
  LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel f ON e.ID = f.mainid              
  LEFT JOIN T_HN_Main_ProjGeneralInfo g ON a.ID = g.mainid               
  LEFT JOIN (select ProjCode,MAX(ProjManagerID)AS ProjManagerID              
     from T_HN_ProjectManager group by ProjCode) as h ON a.ProjCode = h.ProjCode               
  LEFT JOIN T_HN_ReviewEnterpriseInfo i ON c.CI_UnitCode = i.USER_NAME               
  LEFT JOIN T_HN_Main_BuildingInfo j ON a.ID = j.mainid                           
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
    WHEN 1 THEN '�ؼ�'              
    WHEN 2 THEN 'һ��'              
    WHEN 3 THEN '����'               
    ELSE '����'               
   END AS ProjGreade ,            
   ISNULL(a.UnitName,'') AS UnitName,              
   ISNULL(b.PI_ConPermissionNo,'') AS PI_ConPermissionNo,               
   SurveyUnitName = ISNULL((SELECT   top 1 bb.SD_SurveyDesignUnitName               
        FROM T_HN_Main aa               
        LEFT JOIN T_HN_Main_SurveyDesignUnit bb ON aa.ID = bb.mainid               
        WHERE aa.ID = @ID AND bb.SD_DesignContent = '1' and IsNull(bb.SD_IsMainDesign,-1) <> '0'),''),              
   SurveyCertificateNo = ISNULL(stuff(( select  top 1 ee.EQ_CertificateNo               
         FROM T_HN_DesignEnterpriseInfo cc               
        INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.User_Name = dd.SD_UnitCode AND dd.SD_DesignContent = '1'   and IsNull(dd.SD_IsMainDesign,-1) <> '0'            
         LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid               
         WHERE CHARINDEX(ee.EQ_QualificationCategory,'����') > 0 AND dd.mainid = @ID FOR XML path('') ), 1, 1, ''),'0'),              
   DesignUnitName = ISNULL((SELECT  top 1    bb.SD_SurveyDesignUnitName              
        FROM T_HN_Main aa              
        LEFT JOIN T_HN_Main_SurveyDesignUnit bb ON aa.ID = bb.mainid               
        WHERE aa.ID = @ID AND bb.SD_DesignContent = '2'),''),               
   DesignCertificateNo = ISNULL(stuff(( select  top 1 ee.EQ_CertificateNo              
         FROM T_HN_DesignEnterpriseInfo cc               
         INNER JOIN T_HN_Main_SurveyDesignUnit dd ON cc.User_Name = dd.SD_UnitCode AND dd.SD_DesignContent = '2'  and IsNull(d.SD_IsMainDesign,-1) <> '0'            
         LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel ee ON cc.ID = ee.mainid               
         WHERE CHARINDEX(ee.EQ_QualificationCategory,'����') > 0 AND dd.mainid = @ID FOR XML path('') ), 1, 1, ''),'0') ,               
   ISNULL(g.PG_MainConstructionContent,'') AS PG_MainConstructionContent,               
   ISNULL(h.ProjManagerID,'') AS ProjManagerID ,              
   ISNULL(i.CTO,'') AS CTO,              
   ISNULL(i.LegalName,'')  AS LegalName              
  FROM T_HN_Main a               
  LEFT JOIN T_HN_Main_ProjInfo b ON a.ID = b.mainid               
  LEFT JOIN T_HN_Main_CensorshipInfo C ON a.ID = c.mainid               
  LEFT JOIN T_HN_Main_SurveyDesignUnit d ON a.ID = d.mainid AND c.CI_WorkInstancesID = d.SD_WorkInstancesID AND d.SD_DesignContent = '1'  and IsNull(d.SD_IsMainDesign,-1) <> '0'            
  LEFT JOIN T_HN_DesignEnterpriseInfo e ON d.SD_UnitCode = e.User_Name               
  LEFT JOIN T_HN_DesignEnterpriseInfo_QLevel f ON e.ID = f.mainid              
  LEFT JOIN T_HN_Main_ProjGeneralInfo g ON a.ID = g.mainid               
  LEFT JOIN (select ProjCode,MAX(ProjManagerID)AS ProjManagerID               
     from T_HN_ProjectManager group by ProjCode) as h ON a.ProjCode = h.ProjCode              
  LEFT JOIN T_HN_ReviewEnterpriseInfo i ON c.CI_UnitCode = i.User_Name               
  WHERE a.ID = @ID               
 END              
END 