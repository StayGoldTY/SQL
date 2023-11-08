create table `pkpm-bureau`.sys_role
(
    id          varchar(32)  not null comment '主键id'
        primary key,
    role_name   varchar(200) null comment '角色名称',
    role_code   varchar(100) not null comment '角色编码',
    description varchar(255) null comment '描述',
    create_by   varchar(32)  null comment '创建人',
    create_time datetime     null comment '创建时间',
    update_by   varchar(32)  null comment '更新人',
    update_time datetime     null comment '更新时间',
    constraint uniq_sys_role_role_code
        unique (role_code)
)
    comment '角色表' charset = utf8;

create index idx_sr_role_code
    on `pkpm-bureau`.sys_role (role_code);

