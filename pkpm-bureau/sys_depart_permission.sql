create table `pkpm-bureau`.sys_depart_permission
(
    id            varchar(32)   not null
        primary key,
    depart_id     varchar(32)   null comment '部门id',
    permission_id varchar(32)   null comment '权限id',
    data_rule_ids varchar(1000) null comment '数据规则id'
)
    comment '部门权限表' charset = utf8;

