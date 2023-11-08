create table `pkpm-bureau`.sys_third_account
(
    id              varchar(32)  not null comment '编号'
        primary key,
    sys_user_id     varchar(32)  null comment '第三方登录id',
    avatar          varchar(255) null comment '头像',
    status          tinyint(1)   null comment '状态(1-正常,2-冻结)',
    del_flag        tinyint(1)   null comment '删除状态(0-正常,1-已删除)',
    realname        varchar(100) null comment '真实姓名',
    third_user_uuid varchar(100) null comment '第三方账号',
    third_user_id   varchar(100) null comment '第三方app用户账号',
    third_type      varchar(50)  null comment '登录来源',
    constraint uniq_sys_third_account_third_type_third_user_id
        unique (third_type, third_user_id)
);

