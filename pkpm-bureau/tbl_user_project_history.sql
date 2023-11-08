create table `pkpm-bureau`.tbl_user_project_history
(
    id               varchar(36)            not null comment '主键'
        primary key,
    create_by        varchar(50)            null comment '创建人',
    create_time      datetime               null comment '创建日期',
    update_by        varchar(50)            null comment '更新人',
    update_time      datetime               null comment '更新日期',
    sys_org_code     varchar(64)            null comment '所属部门',
    user_id          varchar(36)            null comment '文件用户id',
    dir_path         varchar(64)            null comment '所在根目录',
    file_name        varchar(64)            null comment '文件名称',
    file_loc         varchar(256)           null comment '文件本地loc',
    file_up_loc      varchar(256)           null comment '文件远程loc',
    up_loc_ip        varchar(32)            null comment '上传主机',
    iz_cloud         varchar(1) default '0' null comment '是否上云',
    cloud_loc        varchar(200)           null comment '云端loc',
    file_real_name   varchar(100)           null comment '文件实际名称',
    file_ver         int        default 1   null comment '版本',
    iz_delete        varchar(1) default '0' null comment '删除标志',
    proj_name        varchar(64)            null comment '项目名称',
    proj_code        varchar(64)            null comment '项目编码',
    iz_latest        varchar(1) default '1' null comment '是否最新',
    file_type        varchar(12)            null comment '文件类型',
    file_size        varchar(36)            null comment '文件大小',
    cloud_file_id    varchar(36)            null comment '云端文件id',
    iz_sync          varchar(1) default '0' null comment '是否同步',
    sync_origin_user varchar(64)            null comment '源上传人ID',
    sync_origin_id   varchar(64)            null comment '源文件id'
)
    comment '项目文件用户记录' row_format = DYNAMIC;

