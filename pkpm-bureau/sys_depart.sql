create table `pkpm-bureau`.sys_depart
(
    id               varchar(32)             not null comment 'ID'
        primary key,
    parent_id        varchar(32)             null comment '父机构ID',
    depart_name      varchar(100)            not null comment '机构/部门名称',
    depart_name_en   varchar(500)            null comment '英文名',
    depart_name_abbr varchar(500)            null comment '缩写',
    depart_order     int         default 0   null comment '排序',
    description      varchar(500)            null comment '描述',
    org_category     varchar(10) default '1' not null comment '机构类别 1公司，2组织机构，2岗位',
    org_type         varchar(10)             null comment '机构类型 1一级部门 2子部门',
    org_code         varchar(64)             not null comment '机构编码',
    mobile           varchar(32)             null comment '手机号',
    fax              varchar(32)             null comment '传真',
    address          varchar(100)            null comment '地址',
    memo             varchar(500)            null comment '备注',
    status           varchar(1)              null comment '状态（1启用，0不启用）',
    del_flag         varchar(1)              null comment '删除状态（0，正常，1已删除）',
    qywx_identifier  varchar(100)            null comment '对接企业微信的ID',
    create_by        varchar(32)             null comment '创建人',
    create_time      datetime                null comment '创建日期',
    update_by        varchar(32)             null comment '更新人',
    update_time      datetime                null comment '更新日期',
    map_code         varchar(36)             null,
    data_org_code    varchar(200)            null,
    data_id          varchar(200)            null,
    constraint uniq_depart_org_code
        unique (org_code)
)
    comment '组织机构表' charset = utf8;

create index idx_sd_depart_order
    on `pkpm-bureau`.sys_depart (depart_order);

create index idx_sd_org_code
    on `pkpm-bureau`.sys_depart (org_code);

create index idx_sd_parent_id
    on `pkpm-bureau`.sys_depart (parent_id);

create index index_depart_depart_order
    on `pkpm-bureau`.sys_depart (depart_order);

create index index_depart_org_code
    on `pkpm-bureau`.sys_depart (org_code);

create index index_depart_parent_id
    on `pkpm-bureau`.sys_depart (parent_id);

