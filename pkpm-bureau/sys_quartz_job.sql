create table `pkpm-bureau`.sys_quartz_job
(
    id              varchar(32)  not null
        primary key,
    create_by       varchar(32)  null comment '创建人',
    create_time     datetime     null comment '创建时间',
    del_flag        int(1)       null comment '删除状态',
    update_by       varchar(32)  null comment '修改人',
    update_time     datetime     null comment '修改时间',
    job_class_name  varchar(255) null comment '任务类名',
    cron_expression varchar(255) null comment 'cron表达式',
    parameter       varchar(255) null comment '参数',
    description     varchar(255) null comment '描述',
    status          int(1)       null comment '状态 0正常 -1停止'
)
    charset = utf8;

