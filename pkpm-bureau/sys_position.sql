create table `pkpm-bureau`.sys_position
(
    id           varchar(32)  not null
        primary key,
    code         varchar(100) null comment '职务编码',
    name         varchar(100) null comment '职务名称',
    post_rank    varchar(2)   null comment '职级',
    company_id   varchar(255) null comment '公司id',
    create_by    varchar(50)  null comment '创建人',
    create_time  datetime     null comment '创建时间',
    update_by    varchar(50)  null comment '修改人',
    update_time  datetime     null comment '修改时间',
    sys_org_code varchar(50)  null comment '组织机构编码',
    constraint uniq_code
        unique (code)
)
    charset = utf8;

