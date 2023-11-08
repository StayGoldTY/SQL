create table `pkpm-bureau`.tbl_user_project_relation
(
    id           varchar(36)            not null
        primary key,
    create_by    varchar(50)            null comment '创建人',
    create_time  datetime               null comment '创建日期',
    update_by    varchar(50)            null comment '更新人',
    update_time  datetime               null comment '更新日期',
    sys_org_code varchar(64)            null comment '所属部门',
    iz_delete    varchar(1) default '0' null comment '删除',
    proj_code    varchar(64)            null comment '项目编码',
    template_id  varchar(36)            null comment '模板id',
    rels_stat    varchar(1) default '0' null comment '发布状态'
)
    charset = utf8;

