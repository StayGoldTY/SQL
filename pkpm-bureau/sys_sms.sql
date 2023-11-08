create table `pkpm-bureau`.sys_sms
(
    id             varchar(32)   not null comment 'ID'
        primary key,
    es_title       varchar(100)  null comment '消息标题',
    es_type        varchar(1)    null comment '发送方式：1短信 2邮件 3微信',
    es_receiver    varchar(50)   null comment '接收人',
    es_param       varchar(1000) null comment '发送所需参数Json格式',
    es_content     longtext      null comment '推送内容',
    es_send_time   datetime      null comment '推送时间',
    es_send_status varchar(1)    null comment '推送状态 0未推送 1推送成功 2推送失败 -1失败不再发送',
    es_send_num    int           null comment '发送次数 超过5次不再发送',
    es_result      varchar(255)  null comment '推送失败原因',
    remark         varchar(500)  null comment '备注',
    create_by      varchar(32)   null comment '创建人登录名称',
    create_time    datetime      null comment '创建日期',
    update_by      varchar(32)   null comment '更新人登录名称',
    update_time    datetime      null comment '更新日期'
)
    charset = utf8;

create index idx_ss_es_receiver
    on `pkpm-bureau`.sys_sms (es_receiver);

create index idx_ss_es_send_status
    on `pkpm-bureau`.sys_sms (es_send_status);

create index idx_ss_es_send_time
    on `pkpm-bureau`.sys_sms (es_send_time);

create index idx_ss_es_type
    on `pkpm-bureau`.sys_sms (es_type);

create index index_receiver
    on `pkpm-bureau`.sys_sms (es_receiver);

create index index_sendtime
    on `pkpm-bureau`.sys_sms (es_send_time);

create index index_status
    on `pkpm-bureau`.sys_sms (es_send_status);

create index index_type
    on `pkpm-bureau`.sys_sms (es_type);

