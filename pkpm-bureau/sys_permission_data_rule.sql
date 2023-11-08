create table `pkpm-bureau`.sys_permission_data_rule
(
    id              varchar(32)  not null comment 'ID'
        primary key,
    permission_id   varchar(32)  null comment '菜单ID',
    rule_name       varchar(50)  null comment '规则名称',
    rule_column     varchar(50)  null comment '字段',
    rule_conditions varchar(50)  null comment '条件',
    rule_value      varchar(300) null comment '规则值',
    status          varchar(3)   null comment '权限有效状态1有0否',
    create_time     datetime     null comment '创建时间',
    create_by       varchar(32)  null,
    update_time     datetime     null comment '修改时间',
    update_by       varchar(32)  null comment '修改人'
)
    charset = utf8;

create index idx_spdr_permission_id
    on `pkpm-bureau`.sys_permission_data_rule (permission_id);

create index index_fucntionid
    on `pkpm-bureau`.sys_permission_data_rule (permission_id);

