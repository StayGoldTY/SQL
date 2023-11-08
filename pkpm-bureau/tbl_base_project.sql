create table `pkpm-bureau`.tbl_base_project
(
    id           varchar(36)            not null
        primary key,
    create_by    varchar(50)            null comment '创建人',
    create_time  datetime               null comment '创建日期',
    update_by    varchar(50)            null comment '更新人',
    update_time  datetime               null comment '更新日期',
    sys_org_code varchar(64)            null comment '所属部门',
    proj_code    varchar(64)            null comment '项目编码',
    proj_name    varchar(64)            null comment '项目名称',
    iz_delete    varchar(1) default '0' null comment '删除标志',
    proj_desc    varchar(500)           null comment '项目描述',
    proj_addr    varchar(255)           null,
    proj_status  varchar(1) default 'Y' null comment '启用Y停用N'
)
    charset = utf8;

