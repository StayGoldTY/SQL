create table `pkpm-bureau`.sys_data_source
(
    id           varchar(36)  not null
        primary key,
    code         varchar(100) null comment '数据源编码',
    name         varchar(100) null comment '数据源名称',
    remark       varchar(200) null comment '备注',
    db_type      varchar(10)  null comment '数据库类型',
    db_driver    varchar(100) null comment '驱动类',
    db_url       varchar(500) null comment '数据源地址',
    db_name      varchar(100) null comment '数据库名称',
    db_username  varchar(100) null comment '用户名',
    db_password  varchar(100) null comment '密码',
    create_by    varchar(50)  null comment '创建人',
    create_time  datetime     null comment '创建日期',
    update_by    varchar(50)  null comment '更新人',
    update_time  datetime     null comment '更新日期',
    sys_org_code varchar(64)  null comment '所属部门',
    constraint sys_data_source_code_uni
        unique (code),
    constraint uk_sdc_rule_code
        unique (code)
);

