create table `pkpm-bureau`.sys_dict
(
    id          varchar(32)                        not null
        primary key,
    dict_name   varchar(100)                       not null comment '字典名称',
    dict_code   varchar(100)                       not null comment '字典编码',
    description varchar(255)                       null comment '描述',
    del_flag    int(1)                             null comment '删除状态',
    create_by   varchar(32)                        null comment '创建人',
    create_time datetime                           null comment '创建时间',
    update_by   varchar(32)                        null comment '更新人',
    update_time datetime                           null comment '更新时间',
    type        int(1) unsigned zerofill default 0 null comment '字典类型0为string,1为number',
    constraint indextable_dict_code
        unique (dict_code),
    constraint uk_sd_dict_code
        unique (dict_code)
)
    charset = utf8;

