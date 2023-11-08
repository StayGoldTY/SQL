create table `pkpm-bureau`.tbl_app_store
(
    id           varchar(36)            not null
        primary key,
    create_by    varchar(50)            null comment '创建人',
    create_time  datetime               null comment '创建日期',
    update_by    varchar(50)            null comment '更新人',
    update_time  datetime               null comment '更新日期',
    sys_org_code varchar(64)            null comment '所属部门',
    app_title    varchar(32)            null comment 'app名称',
    app_size     varchar(64)            null comment '大小',
    auth_type    varchar(32)            null comment '授权方式',
    version      varchar(32)            null comment '版本',
    pub_date     datetime               null comment '发布日期',
    file_path    varchar(200)           null comment '下载地址',
    iz_delete    varchar(1) default '0' null comment '删除标志',
    pub_state    varchar(1) default '0' null comment '发布状态',
    app_icon     varchar(100)           null comment 'app图标',
    app_dsp      varchar(200)           null comment '软件描述',
    started_path varchar(256)           null comment '安装包路径',
    app_key      varchar(10)            null comment 'app_key'
)
    charset = utf8;

