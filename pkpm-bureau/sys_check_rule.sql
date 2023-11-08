create table `pkpm-bureau`.sys_check_rule
(
    id               varchar(32) charset utf8 not null comment '主键id'
        primary key,
    rule_name        varchar(100)             null comment '规则名称',
    rule_code        varchar(100)             null comment '规则Code',
    rule_json        varchar(1024)            null comment '规则JSON',
    rule_description varchar(200)             null comment '规则描述',
    update_by        varchar(32) charset utf8 null comment '更新人',
    update_time      datetime                 null comment '更新时间',
    create_by        varchar(32) charset utf8 null comment '创建人',
    create_time      datetime                 null comment '创建时间',
    constraint uk_scr_rule_code
        unique (rule_code),
    constraint uni_sys_check_rule_code
        unique (rule_code)
);

