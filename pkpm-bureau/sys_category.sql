create table `pkpm-bureau`.sys_category
(
    id           varchar(36)  not null
        primary key,
    pid          varchar(36)  null comment '父级节点',
    name         varchar(100) null comment '类型名称',
    code         varchar(100) null comment '类型编码',
    create_by    varchar(50)  null comment '创建人',
    create_time  datetime     null comment '创建日期',
    update_by    varchar(50)  null comment '更新人',
    update_time  datetime     null comment '更新日期',
    sys_org_code varchar(64)  null comment '所属部门',
    has_child    varchar(3)   null comment '是否有子节点',
    constraint index_code
        unique (code)
)
    charset = utf8;

create index idx_sc_code
    on `pkpm-bureau`.sys_category (code);

