go
--������Ҫ�޸ĵ�
update T_SYS_DBASECATALOG set SERVERIP = '116.242.92.59,9092',[DATABASE] = 'hnstdb_test' ,PASSWORD = 'pkpm=202O' where id = '6867b720db9c42409b019083f3fa649d'
update T_SYS_DBASECATALOG set SERVERIP = '116.242.92.59,9092',PASSWORD = 'pkpm=202O' where id = '76bf67f03e004a81b75202a520ff2ec7'

--��ԭ
update T_SYS_DBASECATALOG set SERVERIP = '10.111.155.114',[DATABASE] = 'hnstdb' ,PASSWORD = 'hnpkpm@2021!' where id = '6867b720db9c42409b019083f3fa649d'
update T_SYS_DBASECATALOG set SERVERIP = '10.111.155.114',PASSWORD = 'hnpkpm@2021!' where id = '76bf67f03e004a81b75202a520ff2ec7'
go
--�ų�����Ԥ��Ĺ���ֵ
update T_SYS_REPORTS set FILTERS =  replace(CONVERT(NVARCHAR(4000),FILTERS),'false','true')

--��ԭ�ų�����Ԥ��Ĺ���ֵ
update T_SYS_REPORTS set FILTERS =  replace(CONVERT(NVARCHAR(4000),FILTERS),'false','true')
go
--��DBSQL�����ע����ʽ���ĳɿ�ע��
update T_SYS_REPORTS set DBSQL =  replace(CONVERT(NVARCHAR(max),DBSQL),'---����','/*����*/')

--��ԭ��DBSQL�����ע����ʽ���ĳɿ�ע��
update T_SYS_REPORTS set DBSQL =  replace(CONVERT(NVARCHAR(max),DBSQL),'/*����*/','---����')
go
alter table T_SYS_REPORTS add  orderid int default 1000
go
update T_SYS_REPORTS set orderid = 1000
go
--�ѱ��ֶε�COLLATE���޸ĳ�һ����
ALTER TABLE T_SYS_REPORT_AUTH ALTER COLUMN TOPICID ?nvarchar(32) COLLATE Chinese_PRC_CI_AS NOT NULL
GO

go
--ʩ����ɷ������ͳ�Ʊ������Ż���ͳ�ƣ�
update T_SYS_REPORTS set orderid = 10  where id = '04595758044647e7a91e8e725e5ed3a3'
--ʩ����ɷ������ͳ�Ʊ�������ͳ�ƣ�
update T_SYS_REPORTS set orderid = 20 where id = '9acfa4c3512a402d8176e94e5831302a'
--ʩ�����������������;��
update T_SYS_REPORTS set orderid = 30 where id = '4194aa2444e040959567510f8d2d8261'
--ʩ���������������ͬ��
update T_SYS_REPORTS set orderid = 40 where id = '41dfff33646342e8a4f0a20da1c3dca4'
--ʩ���������(������λ����)
update T_SYS_REPORTS set orderid = 50 where id = '76f41d960a454572ab757d9a767b9532'
--��������ͳ��
update T_SYS_REPORTS set orderid = 60 where id = '2fa5beedcfbb4171b09086eaaa7d2ed2'
--�ڽ�����ͳ��
update T_SYS_REPORTS set orderid = 70 where id = '2120c5b718bd4059840eef15624cd0ff'
--�깤����ͳ��
update T_SYS_REPORTS set orderid = 80 where id = '9f52849ed62a4486bfcfaf8b2f61bb8c'
--�����ͼ��Ŀͳ��
update T_SYS_REPORTS set orderid = 90 where id = '7ec89734cdcc45d79cfb22a18e70aa0c'
--����Ա��Ϣ������
update T_SYS_REPORTS set orderid = 100 where id = 'e237eca3e1c9473c93db53b9a2bc61f9'