create table `pkpm-bureau`.sys_role_permission
(
    id            varchar(32)   not null
        primary key,
    role_id       varchar(32)   null comment '角色id',
    permission_id varchar(32)   null comment '权限id',
    data_rule_ids varchar(1000) null comment '数据权限ids',
    operate_date  datetime      null comment '操作时间',
    operate_ip    varchar(20)   null comment '操作ip'
)
    comment '角色权限表' charset = utf8;

create index idx_srp_permission_id
    on `pkpm-bureau`.sys_role_permission (permission_id);

create index idx_srp_role_id
    on `pkpm-bureau`.sys_role_permission (role_id);

create index idx_srp_role_per_id
    on `pkpm-bureau`.sys_role_permission (role_id, permission_id);

create index index_group_per_id
    on `pkpm-bureau`.sys_role_permission (permission_id);

create index index_group_role_id
    on `pkpm-bureau`.sys_role_permission (role_id);

create index index_group_role_per_id
    on `pkpm-bureau`.sys_role_permission (role_id, permission_id);
