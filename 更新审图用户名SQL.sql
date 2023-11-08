update T_HN_EnterpriseUser set EnterprisesType = '1', AuditStatus = 1 ,RoleName = 'QYJS',PassWord = 'ty401123456',username = '华健南方建设集团有限公司 '
where user_name = 'ty401'

update T_HN_EnterpriseUser set EnterprisesType = '0', AuditStatus = 2 ,RoleName = 'ZG',PassWord = 'ty301123456' ,username = '海口市住建局 '
where user_name = 'ty301'

update T_HN_EnterpriseUser set EnterprisesType = '0', AuditStatus = 2 ,RoleName = 'ZG',PassWord = 'ty201123456' ,username = '省住建厅 '
where user_name = 'ty201'
