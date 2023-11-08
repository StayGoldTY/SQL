create table `pkpm-bureau`.tbl_user_project
(
    id      varchar(32) not null comment '主键id'
        primary key,
    user_id varchar(32) null comment '用户id',
    proj_id varchar(32) null comment '角色id'
)
    comment '用户角色表' charset = utf8;

create index idx_sur_role_id
    on `pkpm-bureau`.tbl_user_project (proj_id);

create index idx_sur_user_id
    on `pkpm-bureau`.tbl_user_project (user_id);

create index idx_sur_user_role_id
    on `pkpm-bureau`.tbl_user_project (user_id, proj_id);

create index index2_groupuu_ole_id
    on `pkpm-bureau`.tbl_user_project (proj_id);

create index index2_groupuu_user_id
    on `pkpm-bureau`.tbl_user_project (user_id);

create index index2_groupuu_useridandroleid
    on `pkpm-bureau`.tbl_user_project (user_id, proj_id);

