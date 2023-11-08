create table `pkpm-bureau`.sys_gateway_route
(
    id           varchar(36) not null
        primary key,
    router_id    varchar(50) null comment '路由ID',
    name         varchar(32) null comment '服务名',
    uri          varchar(32) null comment '服务地址',
    predicates   text        null comment '断言',
    filters      text        null comment '过滤器',
    retryable    int(3)      null comment '是否重试:0-否 1-是',
    strip_prefix int(3)      null comment '是否忽略前缀0-否 1-是',
    persistable  int(3)      null comment '是否为保留数据:0-否 1-是',
    show_api     int(3)      null comment '是否在接口文档中展示:0-否 1-是',
    status       int(3)      null comment '状态:0-无效 1-有效',
    create_by    varchar(50) null comment '创建人',
    create_time  datetime    null comment '创建日期',
    update_by    varchar(50) null comment '更新人',
    update_time  datetime    null comment '更新日期',
    sys_org_code varchar(64) null comment '所属部门'
)
    charset = utf8;

