create table `pkpm-bureau`.onl_cgreport_param
(
    id          varchar(36) not null
        primary key,
    cgrhead_id  varchar(36) not null comment '动态报表ID',
    param_name  varchar(32) not null comment '参数字段',
    param_txt   varchar(32) null comment '参数文本',
    param_value varchar(32) null comment '参数默认值',
    order_num   int         null comment '排序',
    create_by   varchar(50) null comment '创建人登录名称',
    create_time datetime    null comment '创建日期',
    update_by   varchar(50) null comment '更新人登录名称',
    update_time datetime    null comment '更新日期'
)
    charset = utf8;

create index idx_cgrheadid
    on `pkpm-bureau`.onl_cgreport_param (cgrhead_id);

create index idx_ocp_cgrhead_id
    on `pkpm-bureau`.onl_cgreport_param (cgrhead_id);

