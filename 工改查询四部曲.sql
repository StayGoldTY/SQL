  --1
  SELECT ProjectCode,Guid,* FROM Base_ProjectInfo where projectname like '%бнЪО%'
  and  ProjectCode <> '2110-460200-04-01-995438'
  --2
    SELECT * FROM WD_WorkDrawing 
	WHERE ProjectGuid = '116e9a59-5057-4de9-bb85-bbad295a80a4'


     --3
    SELECT dt_code, * FROM dj_zxxx WHERE zxxx_cgfb_id = '5af4903d44694ce89a8fc511f3ebbea1'
	 --4
   select * from WD_UnitProjectInfo where UnitProjectGuid = 'e6aa5047-6dd8-49dd-b2bc-1f6e464d08e0'