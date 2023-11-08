create table `pkpm-bureau`.tbl_file_sync_schedule
(
    id             varchar(36) default ''  not null
        primary key,
    create_by      varchar(50)             null comment '创建人',
    create_time    datetime                null comment '创建日期',
    update_by      varchar(50)             null comment '更新人',
    update_time    datetime                null comment '更新日期',
    sys_org_code   varchar(64)             null comment '所属部门',
    sync_type      varchar(6)              null comment '同步类型',
    sync_origin_id varchar(32)             null comment '同步源文件id',
    sync_status    varchar(10) default '0' null comment '同步状态',
    sync_host_ip   varchar(32)             null comment '同步主机地址',
    iz_delete      varchar(1)  default '0' null comment '删除标志',
    sync_josn      text                    null comment '同步参数'
);

