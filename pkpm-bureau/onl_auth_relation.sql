create table `pkpm-bureau`.onl_auth_relation
(
    id        varchar(32) not null
        primary key,
    role_id   varchar(32) null comment '角色id',
    auth_id   varchar(32) null comment '权限id',
    type      int(1)      null comment '1字段 2按钮 3数据权限',
    cgform_id varchar(32) null comment 'online表单ID',
    auth_mode varchar(50) null comment '授权方式role角色，depart部门，user人'
);

