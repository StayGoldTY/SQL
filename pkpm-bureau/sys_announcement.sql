create table `pkpm-bureau`.sys_announcement
(
    id           varchar(32)             not null
        primary key,
    titile       varchar(100)            null comment '标题',
    msg_content  text                    null comment '内容',
    start_time   datetime                null comment '开始时间',
    end_time     datetime                null comment '结束时间',
    sender       varchar(100)            null comment '发布人',
    priority     varchar(255)            null comment '优先级（L低，M中，H高）',
    msg_category varchar(10) default '2' not null comment '消息类型1:通知公告2:系统消息',
    msg_type     varchar(10)             null comment '通告对象类型（USER:指定用户，ALL:全体用户）',
    send_status  varchar(10)             null comment '发布状态（0未发布，1已发布，2已撤销）',
    send_time    datetime                null comment '发布时间',
    cancel_time  datetime                null comment '撤销时间',
    del_flag     varchar(1)              null comment '删除状态（0，正常，1已删除）',
    bus_type     varchar(20)             null comment '业务类型(email:邮件 bpm:流程)',
    bus_id       varchar(50)             null comment '业务id',
    open_type    varchar(20)             null comment '打开方式(组件：component 路由：url)',
    open_page    varchar(255)            null comment '组件/路由 地址',
    create_by    varchar(32)             null comment '创建人',
    create_time  datetime                null comment '创建时间',
    update_by    varchar(32)             null comment '更新人',
    update_time  datetime                null comment '更新时间',
    user_ids     text                    null comment '指定用户',
    msg_abstract text                    null comment '摘要',
    dt_task_id   varchar(100)            null comment '钉钉task_id，用于撤回消息'
)
    comment '系统通告表' charset = utf8;

