create table `pkpm-bureau`.sys_tenant
(
    id          int(5)       not null comment '租户编码'
        primary key,
    name        varchar(100) null comment '租户名称',
    create_time datetime     null comment '创建时间',
    create_by   varchar(100) null comment '创建人',
    begin_date  datetime     null comment '开始时间',
    end_date    datetime     null comment '结束时间',
    status      int(1)       null comment '状态 1正常 0冻结'
)
    comment '多租户信息表';

