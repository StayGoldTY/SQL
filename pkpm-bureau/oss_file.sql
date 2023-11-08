create table `pkpm-bureau`.oss_file
(
    id          varchar(32)  not null comment '主键id'
        primary key,
    file_name   varchar(255) null comment '文件名称',
    url         varchar(255) null comment '文件地址',
    create_by   varchar(32)  null comment '创建人登录名称',
    create_time datetime     null comment '创建日期',
    update_by   varchar(32)  null comment '更新人登录名称',
    update_time datetime     null comment '更新日期'
)
    comment 'Oss File' charset = utf8;

