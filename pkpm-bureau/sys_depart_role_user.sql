create table `pkpm-bureau`.sys_depart_role_user
(
    id       varchar(32) not null comment '主键id'
        primary key,
    user_id  varchar(32) null comment '用户id',
    drole_id varchar(32) null comment '角色id'
)
    comment '部门角色用户表' charset = utf8;

