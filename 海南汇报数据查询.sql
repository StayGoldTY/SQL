select * from T_HN_Main where UnitCode = '91469006069695197F' and ProjStatus = 10

update T_HN_Main set DeletionStateCode = '0'  where UnitCode = '91469006069695197F' and ProjStatus = 10

select * from T_HN_Main_SurveyDesignUnit where MainID in (select id from T_HN_Main where UnitCode = '91469006069695197F') and SD_DesignContent = 1

select * from T_HN_Main_ProjGeneralInfo where  MainID in (select id from T_HN_Main where UnitCode = '91469006069695197F')  and PG_ProjType = 1

select * from T_HN_Main_D where MainID in (select id from T_HN_Main where UnitCode = '91469006069695197F' and ProjStatus = 10)

select * from T_HN_PersonalUser where username

select distinct CompanyName from T_HN_EnterpriseUser where SocialCreditCode in (

select distinct SocialCreditCode from T_HN_EnterpriseUser where CompanyName like '%º£ÄÏ%')