create table `pkpm-bureau`.onl_cgform_index
(
    id             varchar(36)            not null comment '主键'
        primary key,
    cgform_head_id varchar(32)            null comment '主表id',
    index_name     varchar(100)           null comment '索引名称',
    index_field    varchar(500)           null comment '索引栏位',
    index_type     varchar(32)            null comment '索引类型',
    create_by      varchar(50)            null comment '创建人登录名称',
    create_time    datetime               null comment '创建日期',
    update_by      varchar(50)            null comment '更新人登录名称',
    update_time    datetime               null comment '更新日期',
    is_db_synch    varchar(2) default 'N' null comment '是否同步数据库 N未同步 Y已同步',
    del_flag       int(1)     default 0   null comment '是否删除 0未删除 1删除'
)
    charset = utf8;

create index idx_oci_cgform_head_id
    on `pkpm-bureau`.onl_cgform_index (cgform_head_id);

create index index_table_id
    on `pkpm-bureau`.onl_cgform_index (cgform_head_id);

