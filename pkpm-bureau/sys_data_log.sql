create table `pkpm-bureau`.sys_data_log
(
    id           varchar(32) not null comment 'id'
        primary key,
    create_by    varchar(32) null comment '创建人登录名称',
    create_time  datetime    null comment '创建日期',
    update_by    varchar(32) null comment '更新人登录名称',
    update_time  datetime    null comment '更新日期',
    data_table   varchar(32) null comment '表名',
    data_id      varchar(32) null comment '数据ID',
    data_content text        null comment '数据内容',
    data_version int         null comment '版本号'
)
    charset = utf8;

create index idx_sdl_data_table_id
    on `pkpm-bureau`.sys_data_log (data_table, data_id);

create index sindex
    on `pkpm-bureau`.sys_data_log (data_table, data_id);

