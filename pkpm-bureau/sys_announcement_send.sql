create table `pkpm-bureau`.sys_announcement_send
(
    id          varchar(32) null,
    annt_id     varchar(32) null comment '通告ID',
    user_id     varchar(32) null comment '用户id',
    read_flag   varchar(10) null comment '阅读状态（0未读，1已读）',
    read_time   datetime    null comment '阅读时间',
    create_by   varchar(32) null comment '创建人',
    create_time datetime    null comment '创建时间',
    update_by   varchar(32) null comment '更新人',
    update_time datetime    null comment '更新时间'
)
    comment '用户通告阅读标记表' charset = utf8;

