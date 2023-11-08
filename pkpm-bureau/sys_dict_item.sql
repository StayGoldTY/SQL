create table `pkpm-bureau`.sys_dict_item
(
    id          varchar(32)  not null
        primary key,
    dict_id     varchar(32)  null comment '字典id',
    item_text   varchar(100) not null comment '字典项文本',
    item_value  varchar(100) not null comment '字典项值',
    description varchar(255) null comment '描述',
    sort_order  int(10)      null comment '排序',
    status      int          null comment '状态（1启用 0不启用）',
    create_by   varchar(32)  null,
    create_time datetime     null,
    update_by   varchar(32)  null,
    update_time datetime     null
)
    charset = utf8;

create index idx_sdi_dict_val
    on `pkpm-bureau`.sys_dict_item (dict_id, item_value);

create index idx_sdi_role_dict_id
    on `pkpm-bureau`.sys_dict_item (dict_id);

create index idx_sdi_role_sort_order
    on `pkpm-bureau`.sys_dict_item (sort_order);

create index idx_sdi_status
    on `pkpm-bureau`.sys_dict_item (status);

create index index_table_dict_id
    on `pkpm-bureau`.sys_dict_item (dict_id);

create index index_table_dict_status
    on `pkpm-bureau`.sys_dict_item (status);

create index index_table_sort_order
    on `pkpm-bureau`.sys_dict_item (sort_order);

