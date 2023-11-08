create table `pkpm-bureau`.onl_auth_page
(
    id          varchar(32)              not null comment ' 主键'
        primary key,
    cgform_id   varchar(32)              null comment 'online表id',
    code        varchar(255)             null comment '字段名/按钮编码',
    type        int(1)                   null comment '1字段 2按钮',
    control     int(1)                   null comment '3可编辑 5可见(仅支持两种状态值3,5)',
    page        int(1)                   null comment '3列表 5表单(仅支持两种状态值3,5)',
    status      int(1)                   null comment '1有效 0无效',
    create_time datetime                 null comment '创建时间',
    create_by   varchar(32) charset utf8 null comment '创建人',
    update_by   varchar(50)              null comment '更新人',
    update_time datetime                 null comment '更新日期'
);

