create table `pkpm-bureau`.sys_log
(
    id            varchar(32)   not null
        primary key,
    log_type      int(2)        null comment '日志类型（1登录日志，2操作日志）',
    log_content   varchar(1000) null comment '日志内容',
    operate_type  int(2)        null comment '操作类型',
    userid        varchar(32)   null comment '操作用户账号',
    username      varchar(100)  null comment '操作用户名称',
    ip            varchar(100)  null comment 'IP',
    method        varchar(500)  null comment '请求java方法',
    request_url   varchar(255)  null comment '请求路径',
    request_param longtext      null comment '请求参数',
    request_type  varchar(10)   null comment '请求类型',
    cost_time     bigint        null comment '耗时',
    create_by     varchar(32)   null comment '创建人',
    create_time   datetime      null comment '创建时间',
    update_by     varchar(32)   null comment '更新人',
    update_time   datetime      null comment '更新时间'
)
    comment '系统日志表' engine = MyISAM
                         charset = utf8;

create index idx_sl_create_time
    on `pkpm-bureau`.sys_log (create_time);

create index idx_sl_log_type
    on `pkpm-bureau`.sys_log (log_type);

create index idx_sl_operate_type
    on `pkpm-bureau`.sys_log (operate_type);

create index idx_sl_userid
    on `pkpm-bureau`.sys_log (userid);

create index index_log_type
    on `pkpm-bureau`.sys_log (log_type);

create index index_logt_ype
    on `pkpm-bureau`.sys_log (log_type);

create index index_operate_type
    on `pkpm-bureau`.sys_log (operate_type);

create index index_table_userid
    on `pkpm-bureau`.sys_log (userid);

