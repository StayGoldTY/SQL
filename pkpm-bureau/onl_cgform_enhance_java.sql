create table `pkpm-bureau`.onl_cgform_enhance_java
(
    ID             varchar(36)               not null
        primary key,
    BUTTON_CODE    varchar(32)               null comment '按钮编码',
    CG_JAVA_TYPE   varchar(32)               not null comment '类型',
    CG_JAVA_VALUE  varchar(200)              not null comment '数值',
    CGFORM_HEAD_ID varchar(32)               not null comment '表单ID',
    ACTIVE_STATUS  varchar(2)  default '1'   null comment '生效状态',
    EVENT          varchar(10) default 'end' not null comment '事件状态(end:结束，start:开始)'
)
    charset = utf8;

create index idx_ejava_cgform_head_id
    on `pkpm-bureau`.onl_cgform_enhance_java (CGFORM_HEAD_ID);

create index idx_ocej_ACTIVE_STATUS
    on `pkpm-bureau`.onl_cgform_enhance_java (ACTIVE_STATUS);

create index idx_ocej_BUTTON_CODE
    on `pkpm-bureau`.onl_cgform_enhance_java (BUTTON_CODE);

create index index_buttoncode
    on `pkpm-bureau`.onl_cgform_enhance_java (BUTTON_CODE);

create index index_status
    on `pkpm-bureau`.onl_cgform_enhance_java (ACTIVE_STATUS);

