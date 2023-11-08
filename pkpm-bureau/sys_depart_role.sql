create table `pkpm-bureau`.sys_depart_role
(
    id          varchar(32)  not null
        primary key,
    depart_id   varchar(32)  null comment '部门id',
    role_name   varchar(200) null comment '部门角色名称',
    role_code   varchar(100) null comment '部门角色编码',
    description varchar(255) null comment '描述',
    create_by   varchar(32)  null comment '创建人',
    create_time datetime     null comment '创建时间',
    update_by   varchar(32)  null comment '更新人',
    update_time datetime     null comment '更新时间'
)
    comment '部门角色表' charset = utf8;

