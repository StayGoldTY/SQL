 SELECT distinct a.Guid AS ID,a.ProjectName AS ProjName,isNull(b.ProjectCode,'нч') AS ProjCode,
  ISNULL(b.LandPlanningNum,'') AS PI_ConstructionLandNo,a.CreateDate,
  ISNULL(b.LicenseNum,'') AS PI_ConPermissionNo,ISNULL(b.IsKeyProject,'0') AS PI_IsKeyProj,
  REPLACE(c.dt_name,'''','') AS BS_BuildingName,
  REPLACE(c.dt_code,'''','') AS BS_No,
  d.BuildArea,
  d.UpArea,
  d.DownArea,
  d.Category,
  d.UpLayer,
  d.DownLayer,
  IsLimit
  FROM dbo.WD_WorkDrawing   a
  LEFT JOIN dbo.Base_ProjectInfo b ON a.ProjectGuid = b.Guid
  LEFT JOIN dbo.dj_zxxx c on   a.Guid = c.zxxx_cgfb_id
  left join WD_UnitProjectInfo d on c.dt_code like '%' + d.UnitProjectGuid +  '%'
  WHERE  b.ProjectCode IS NOT NULL and c.dt_code is not null
  ORDER BY  a.CreateDate desc,ProjCode


  select * from WD_WorkDrawing where 

  select ProjectCode,* from Base_ProjectInfo where ProjectCode is null

