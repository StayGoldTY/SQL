create table `pkpm-bureau`.tbl_file_catalog
(
    id             varchar(36) charset utf8mb4 not null
        primary key,
    create_by      varchar(50)                 null,
    create_time    datetime                    null,
    update_by      varchar(50)                 null,
    update_time    datetime                    null,
    sys_org_code   varchar(64)                 null,
    iz_delete      varchar(1) default '0'      null,
    parent_id      varchar(36)                 null comment '父id',
    proj_code      varchar(64)                 null comment '项目编号',
    file_name      varchar(200)                null comment '文件名称',
    file_sort      int                         null comment '文件索引',
    template_id    varchar(36)                 null comment '模板id',
    publish_status varchar(10)                 null comment '发布状态',
    file_path      varchar(256)                null comment '目录路径',
    proj_name      varchar(64)                 null comment '项目名称'
)
    comment '测试表' charset = utf8;

