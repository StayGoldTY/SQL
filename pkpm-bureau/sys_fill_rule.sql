create table `pkpm-bureau`.sys_fill_rule
(
    id          varchar(32) charset utf8 not null comment '主键ID'
        primary key,
    rule_name   varchar(100)             null comment '规则名称',
    rule_code   varchar(100)             null comment '规则Code',
    rule_class  varchar(100)             null comment '规则实现类',
    rule_params varchar(200)             null comment '规则参数',
    update_by   varchar(32) charset utf8 null comment '修改人',
    update_time datetime                 null comment '修改时间',
    create_by   varchar(32) charset utf8 null comment '创建人',
    create_time datetime                 null comment '创建时间',
    constraint uk_sfr_rule_code
        unique (rule_code),
    constraint uni_sys_fill_rule_code
        unique (rule_code)
);

