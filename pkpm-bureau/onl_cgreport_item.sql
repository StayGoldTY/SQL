create table `pkpm-bureau`.onl_cgreport_item
(
    id          varchar(36)      not null
        primary key,
    cgrhead_id  varchar(36)      not null comment '报表ID',
    field_name  varchar(36)      not null comment '字段名字',
    field_txt   varchar(300)     null comment '字段文本',
    field_width int(3)           null,
    field_type  varchar(10)      null comment '字段类型',
    search_mode varchar(10)      null comment '查询模式',
    is_order    int(2) default 0 null comment '是否排序  0否,1是',
    is_search   int(2) default 0 null comment '是否查询  0否,1是',
    dict_code   varchar(500)     null comment '字典CODE',
    field_href  varchar(120)     null comment '字段跳转URL',
    is_show     int(2) default 1 null comment '是否显示  0否,1显示',
    order_num   int              null comment '排序',
    replace_val varchar(200)     null comment '取值表达式',
    is_total    varchar(2)       null comment '是否合计 0否,1是（仅对数值有效）',
    group_title varchar(50)      null comment '分组标题',
    create_by   varchar(32)      null comment '创建人',
    create_time datetime         null comment '创建时间',
    update_by   varchar(32)      null comment '修改人',
    update_time datetime         null comment '修改时间'
)
    charset = utf8;

create index idx_oci_cgrhead_id
    on `pkpm-bureau`.onl_cgreport_item (cgrhead_id);

create index idx_oci_is_show
    on `pkpm-bureau`.onl_cgreport_item (is_show);

create index idx_oci_order_num
    on `pkpm-bureau`.onl_cgreport_item (order_num);

create index index_CGRHEAD_ID
    on `pkpm-bureau`.onl_cgreport_item (cgrhead_id);

create index index_isshow
    on `pkpm-bureau`.onl_cgreport_item (is_show);

create index index_order_num
    on `pkpm-bureau`.onl_cgreport_item (order_num);

