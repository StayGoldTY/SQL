create table `pkpm-bureau`.tbl_user_cloud_file_history
(
    id               varchar(36)                  not null
        primary key,
    create_by        varchar(50)                  null comment '创建人',
    create_time      datetime                     null comment '创建日期',
    update_by        varchar(50)                  null comment '更新人',
    update_time      datetime                     null comment '更新日期',
    sys_org_code     varchar(64)                  null comment '所属部门',
    file_name        varchar(32)                  null comment '文件名称',
    file_loc         varchar(256)                 null comment '文件路径',
    up_user_id       varchar(64)                  null comment '上传用户',
    up_origin_ip     varchar(32)                  null comment '上传源地址',
    origin_loc       varchar(256)                 null comment '文件源路径',
    iz_delete        varchar(1) default '0'       null comment '0',
    file_rev         int        default 1         null comment '版本',
    proj_code        varchar(32)                  null comment '项目',
    proj_name        varchar(64)                  null comment '项目名称',
    dir_path         varchar(256)                 null comment '所属目录',
    origin_id        varchar(36)                  null comment '文件源id',
    iz_sync          varchar(1) default '0'       null comment '文件是否同步',
    sync_edge_ip     varchar(256)                 null comment '同步到边源',
    sync_origin_user varchar(64)                  null comment '同步用户',
    file_real_name   varchar(100) charset utf8mb4 null comment '文件实际名称'
)
    charset = utf8;

