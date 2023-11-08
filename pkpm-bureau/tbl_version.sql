create table `pkpm-bureau`.tbl_version
(
    id                varchar(36)            not null
        primary key,
    create_by         varchar(50)            null comment '创建人',
    create_time       datetime               null comment '创建日期',
    update_by         varchar(50)            null comment '更新人',
    update_time       datetime               null comment '更新日期',
    iz_delete         varchar(1) default '0' null comment '删除标志',
    version_no        varchar(50)            not null comment '版本号',
    publish_date      datetime               not null comment '发布时间',
    release_notes     varchar(500)           not null comment '发布内容',
    install_file_path varchar(500)           null comment '安装文件',
    env               varchar(50)            null comment '环境'
)
    comment '版本管理表';

