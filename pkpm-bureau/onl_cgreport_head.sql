create table `pkpm-bureau`.onl_cgreport_head
(
    id               varchar(36)            not null
        primary key,
    code             varchar(100)           not null comment '报表编码',
    name             varchar(100)           not null comment '报表名字',
    cgr_sql          varchar(1000)          not null comment '报表SQL',
    return_val_field varchar(100)           null comment '返回值字段',
    return_txt_field varchar(100)           null comment '返回文本字段',
    return_type      varchar(2) default '1' null comment '返回类型，单选或多选',
    db_source        varchar(100)           null comment '动态数据源',
    content          varchar(1000)          null comment '描述',
    low_app_id       varchar(32)            null comment '关联的应用ID',
    update_time      datetime               null comment '修改时间',
    update_by        varchar(32)            null comment '修改人id',
    create_time      datetime               null comment '创建时间',
    create_by        varchar(32)            null comment '创建人id',
    constraint index_onlinereport_code
        unique (code)
)
    charset = utf8;

create index idx_och_code
    on `pkpm-bureau`.onl_cgreport_head (code);

