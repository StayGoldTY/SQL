create table `pkpm-bureau`.onl_auth_data
(
    id            varchar(32)              not null comment '主键'
        primary key,
    cgform_id     varchar(32)              null comment 'online表ID',
    rule_name     varchar(50)              null comment '规则名',
    rule_column   varchar(50)              null comment '规则列',
    rule_operator varchar(50)              null comment '规则条件 大于小于like',
    rule_value    varchar(255)             null comment '规则值',
    status        int(1)                   null comment '1有效 0无效',
    create_time   datetime                 null comment '创建时间',
    create_by     varchar(50) charset utf8 null comment '创建人',
    update_by     varchar(50)              null comment '更新人',
    update_time   datetime                 null comment '更新日期'
);

