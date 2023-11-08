create table `pkpm-bureau`.onl_cgform_button
(
    ID             varchar(32)  not null comment '主键ID'
        primary key,
    BUTTON_CODE    varchar(50)  null comment '按钮编码',
    BUTTON_ICON    varchar(20)  null comment '按钮图标',
    BUTTON_NAME    varchar(50)  null comment '按钮名称',
    BUTTON_STATUS  varchar(2)   null comment '按钮状态',
    BUTTON_STYLE   varchar(20)  null comment '按钮样式',
    EXP            varchar(255) null comment '表达式',
    CGFORM_HEAD_ID varchar(32)  null comment '表单ID',
    OPT_TYPE       varchar(20)  null comment '按钮类型',
    ORDER_NUM      int          null comment '排序',
    OPT_POSITION   varchar(3)   null comment '按钮位置1侧面 2底部'
)
    comment 'Online表单自定义按钮' charset = utf8;

create index idx_ocb_BUTTON_CODE
    on `pkpm-bureau`.onl_cgform_button (BUTTON_CODE);

create index idx_ocb_BUTTON_STATUS
    on `pkpm-bureau`.onl_cgform_button (BUTTON_STATUS);

create index idx_ocb_CGFORM_HEAD_ID
    on `pkpm-bureau`.onl_cgform_button (CGFORM_HEAD_ID);

create index idx_ocb_ORDER_NUM
    on `pkpm-bureau`.onl_cgform_button (ORDER_NUM);

create index index_button_code
    on `pkpm-bureau`.onl_cgform_button (BUTTON_CODE);

create index index_button_order
    on `pkpm-bureau`.onl_cgform_button (ORDER_NUM);

create index index_button_status
    on `pkpm-bureau`.onl_cgform_button (BUTTON_STATUS);

create index index_formid
    on `pkpm-bureau`.onl_cgform_button (CGFORM_HEAD_ID);

