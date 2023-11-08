create table `pkpm-bureau`.onl_cgform_enhance_js
(
    ID             varchar(32)   not null comment '主键ID'
        primary key,
    CG_JS          longtext      null comment 'JS增强内容',
    CG_JS_TYPE     varchar(20)   null comment '类型',
    CONTENT        varchar(1000) null comment '备注',
    CGFORM_HEAD_ID varchar(32)   null comment '表单ID'
)
    charset = utf8;

create index idx_ejs_cg_js_type
    on `pkpm-bureau`.onl_cgform_enhance_js (CG_JS_TYPE);

create index idx_ejs_cgform_head_id
    on `pkpm-bureau`.onl_cgform_enhance_js (CGFORM_HEAD_ID);

create index index_fmid
    on `pkpm-bureau`.onl_cgform_enhance_js (CGFORM_HEAD_ID);

create index index_jstype
    on `pkpm-bureau`.onl_cgform_enhance_js (CG_JS_TYPE);

