go
--本地需要修改的
update T_SYS_DBASECATALOG set SERVERIP = '116.242.92.59,9092',[DATABASE] = 'hnstdb_test' ,PASSWORD = 'pkpm=202O' where id = '6867b720db9c42409b019083f3fa649d'
update T_SYS_DBASECATALOG set SERVERIP = '116.242.92.59,9092',PASSWORD = 'pkpm=202O' where id = '76bf67f03e004a81b75202a520ff2ec7'

--还原
update T_SYS_DBASECATALOG set SERVERIP = '10.111.155.114',[DATABASE] = 'hnstdb' ,PASSWORD = 'hnpkpm@2021!' where id = '6867b720db9c42409b019083f3fa649d'
update T_SYS_DBASECATALOG set SERVERIP = '10.111.155.114',PASSWORD = 'hnpkpm@2021!' where id = '76bf67f03e004a81b75202a520ff2ec7'
go
--放出所有预设的过滤值
update T_SYS_REPORTS set FILTERS =  replace(CONVERT(NVARCHAR(4000),FILTERS),'false','true')

--还原放出所有预设的过滤值
update T_SYS_REPORTS set FILTERS =  replace(CONVERT(NVARCHAR(4000),FILTERS),'false','true')
go
--把DBSQL里面的注释形式都改成块注释
update T_SYS_REPORTS set DBSQL =  replace(CONVERT(NVARCHAR(max),DBSQL),'---市县','/*市县*/')

--还原把DBSQL里面的注释形式都改成块注释
update T_SYS_REPORTS set DBSQL =  replace(CONVERT(NVARCHAR(max),DBSQL),'/*市县*/','---市县')
go
alter table T_SYS_REPORTS add  orderid int default 1000
go
update T_SYS_REPORTS set orderid = 1000
go
--把表字段的COLLATE都修改成一样的
ALTER TABLE T_SYS_REPORT_AUTH ALTER COLUMN TOPICID ?nvarchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL
GO

go
--施工许可发放情况统计表（按发放机构统计）
update T_SYS_REPORTS set orderid = 10  where id = '04595758044647e7a91e8e725e5ed3a3'
--施工许可发放情况统计表（按市县统计）
update T_SYS_REPORTS set orderid = 20 where id = '9acfa4c3512a402d8176e94e5831302a'
--施工许可审批（工程用途）
update T_SYS_REPORTS set orderid = 30 where id = '4194aa2444e040959567510f8d2d8261'
--施工许可审批（按合同金额）
update T_SYS_REPORTS set orderid = 40 where id = '41dfff33646342e8a4f0a20da1c3dca4'
--施工许可审批(房建单位工程)
update T_SYS_REPORTS set orderid = 50 where id = '76f41d960a454572ab757d9a767b9532'
--竣工备案统计
update T_SYS_REPORTS set orderid = 60 where id = '2fa5beedcfbb4171b09086eaaa7d2ed2'
--在建工程统计
update T_SYS_REPORTS set orderid = 70 where id = '2120c5b718bd4059840eef15624cd0ff'
--完工工程统计
update T_SYS_REPORTS set orderid = 80 where id = '9f52849ed62a4486bfcfaf8b2f61bb8c'
--年度审图项目统计
update T_SYS_REPORTS set orderid = 90 where id = '7ec89734cdcc45d79cfb22a18e70aa0c'
--（人员信息）总体
update T_SYS_REPORTS set orderid = 100 where id = 'e237eca3e1c9473c93db53b9a2bc61f9'