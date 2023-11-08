create table `pkpm-bureau`.sys_user
(
    id             varchar(32)  not null comment '主键id'
        primary key,
    username       varchar(100) null comment '登录账号',
    realname       varchar(100) null comment '真实姓名',
    password       varchar(255) null comment '密码',
    salt           varchar(45)  null comment 'md5密码盐',
    avatar         varchar(255) null comment '头像',
    birthday       datetime     null comment '生日',
    sex            tinyint(1)   null comment '性别(0-默认未知,1-男,2-女)',
    email          varchar(45)  null comment '电子邮件',
    phone          varchar(45)  null comment '电话',
    org_code       varchar(64)  null comment '机构编码',
    org_category   varchar(50)  null comment '机构类型',
    status         tinyint(1)   null comment '性别(1-正常,2-冻结)',
    del_flag       tinyint(1)   null comment '删除状态(0-正常,1-已删除)',
    third_id       varchar(100) null comment '第三方登录的唯一标识',
    third_type     varchar(100) null comment '第三方类型',
    activiti_sync  tinyint(1)   null comment '同步工作流引擎(1-同步,0-不同步)',
    work_no        varchar(100) null comment '工号，唯一键',
    post           varchar(100) null comment '职务，关联职务表',
    telephone      varchar(45)  null comment '座机号',
    create_by      varchar(32)  null comment '创建人',
    create_time    datetime     null comment '创建时间',
    update_by      varchar(32)  null comment '更新人',
    update_time    datetime     null comment '更新时间',
    user_identity  tinyint(1)   null comment '身份（1普通成员 2上级）',
    depart_ids     longtext     null comment '负责部门',
    rel_tenant_ids varchar(100) null comment '多租户标识',
    client_id      varchar(64)  null comment '设备ID',
    data_org_code  varchar(200) null,
    i_d_card       varchar(24)  null,
    constraint index_user_name
        unique (username),
    constraint uniq_sys_user_email
        unique (email),
    constraint uniq_sys_user_phone
        unique (phone),
    constraint uniq_sys_user_username
        unique (username),
    constraint uniq_sys_user_work_no
        unique (work_no)
)
    comment '用户表' charset = utf8;

create index idx_su_del_flag
    on `pkpm-bureau`.sys_user (del_flag);

create index idx_su_status
    on `pkpm-bureau`.sys_user (status);

create index idx_su_username
    on `pkpm-bureau`.sys_user (username);

create index index_user_del_flag
    on `pkpm-bureau`.sys_user (del_flag);

create index index_user_status
    on `pkpm-bureau`.sys_user (status);

