create table `pkpm-bureau`.sys_user_depart
(
    ID      varchar(32) not null comment 'id'
        primary key,
    user_id varchar(32) null comment '用户id',
    dep_id  varchar(32) null comment '部门id'
)
    charset = utf8;

create index idx_sud_dep_id
    on `pkpm-bureau`.sys_user_depart (dep_id);

create index idx_sud_user_dep_id
    on `pkpm-bureau`.sys_user_depart (user_id, dep_id);

create index idx_sud_user_id
    on `pkpm-bureau`.sys_user_depart (user_id);

create index index_depart_groupk_uidanddid
    on `pkpm-bureau`.sys_user_depart (user_id, dep_id);

create index index_depart_groupk_userid
    on `pkpm-bureau`.sys_user_depart (user_id);

create index index_depart_groupkorgid
    on `pkpm-bureau`.sys_user_depart (dep_id);

