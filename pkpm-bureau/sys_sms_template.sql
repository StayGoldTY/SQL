create table `pkpm-bureau`.sys_sms_template
(
    id                 varchar(32)   not null comment '主键'
        primary key,
    template_name      varchar(50)   null comment '模板标题',
    template_code      varchar(32)   not null comment '模板CODE',
    template_type      varchar(1)    not null comment '模板类型：1短信 2邮件 3微信',
    template_content   varchar(1000) not null comment '模板内容',
    template_test_json varchar(1000) null comment '模板测试json',
    create_time        datetime      null comment '创建日期',
    create_by          varchar(32)   null comment '创建人登录名称',
    update_time        datetime      null comment '更新日期',
    update_by          varchar(32)   null comment '更新人登录名称',
    constraint uk_sst_template_code
        unique (template_code),
    constraint uniq_templatecode
        unique (template_code)
)
    charset = utf8;

