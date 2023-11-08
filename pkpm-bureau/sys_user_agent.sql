create table `pkpm-bureau`.sys_user_agent
(
    id               varchar(32)  not null comment '序号'
        primary key,
    user_name        varchar(100) null comment '用户名',
    agent_user_name  varchar(100) null comment '代理人用户名',
    start_time       datetime     null comment '代理开始时间',
    end_time         datetime     null comment '代理结束时间',
    status           varchar(2)   null comment '状态0无效1有效',
    create_name      varchar(50)  null comment '创建人名称',
    create_by        varchar(50)  null comment '创建人登录名称',
    create_time      datetime     null comment '创建日期',
    update_name      varchar(50)  null comment '更新人名称',
    update_by        varchar(50)  null comment '更新人登录名称',
    update_time      datetime     null comment '更新日期',
    sys_org_code     varchar(50)  null comment '所属部门',
    sys_company_code varchar(50)  null comment '所属公司',
    constraint uk_sug_user_name
        unique (user_name),
    constraint uniq_username
        unique (user_name)
)
    comment '用户代理人设置' charset = utf8;

create index begintime_index
    on `pkpm-bureau`.sys_user_agent (start_time);

create index endtime_index
    on `pkpm-bureau`.sys_user_agent (end_time);

create index idx_sug_end_time
    on `pkpm-bureau`.sys_user_agent (end_time);

create index idx_sug_start_time
    on `pkpm-bureau`.sys_user_agent (start_time);

create index idx_sug_status
    on `pkpm-bureau`.sys_user_agent (status);

create index statux_index
    on `pkpm-bureau`.sys_user_agent (status);

