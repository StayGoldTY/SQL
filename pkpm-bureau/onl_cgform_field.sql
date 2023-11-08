create table `pkpm-bureau`.onl_cgform_field
(
    id                  varchar(32)          not null comment '主键ID'
        primary key,
    cgform_head_id      varchar(32)          not null comment '表ID',
    db_field_name       varchar(50)          not null comment '字段名字',
    db_field_txt        varchar(200)         null comment '字段备注',
    db_field_name_old   varchar(50)          null comment '原字段名',
    db_is_key           tinyint(1)           null comment '是否主键 0否 1是',
    db_is_null          tinyint(1)           null comment '是否允许为空0否 1是',
    db_type             varchar(32)          not null comment '数据库字段类型',
    db_length           int                  not null comment '数据库字段长度',
    db_point_length     int                  null comment '小数点',
    db_default_val      varchar(20)          null comment '表字段默认值',
    dict_field          varchar(100)         null comment '字典code',
    dict_table          varchar(255)         null comment '字典表',
    dict_text           varchar(100)         null comment '字典Text',
    field_show_type     varchar(10)          null comment '表单控件类型',
    field_href          varchar(200)         null comment '跳转URL',
    field_length        int                  null comment '表单控件长度',
    field_valid_type    varchar(300)         null comment '表单字段校验规则',
    field_must_input    varchar(2)           null comment '字段是否必填',
    field_extend_json   varchar(500)         null comment '扩展参数JSON',
    field_default_value varchar(100)         null comment '控件默认值，不同的表达式展示不同的结果。
1. 纯字符串直接赋给默认值；
2. #{普通变量}；
3. {{ 动态JS表达式 }}；
4. ${填值规则编码}；
填值规则表达式只允许存在一个，且不能和其他规则混用。',
    is_query            tinyint(1)           null comment '是否查询条件0否 1是',
    is_show_form        tinyint(1)           null comment '表单是否显示0否 1是',
    is_show_list        tinyint(1)           null comment '列表是否显示0否 1是',
    is_read_only        tinyint(1) default 0 null comment '是否是只读（1是 0否）',
    query_mode          varchar(10)          null comment '查询模式',
    main_table          varchar(100)         null comment '外键主表名',
    main_field          varchar(100)         null comment '外键主键字段',
    order_num           int                  null comment '排序',
    update_by           varchar(32)          null comment '修改人',
    update_time         datetime             null comment '修改时间',
    create_time         datetime             null comment '创建时间',
    create_by           varchar(255)         null comment '创建人',
    converter           varchar(255)         null comment '自定义值转换器',
    query_def_val       varchar(50)          null comment '查询默认值',
    query_dict_text     varchar(100)         null comment '查询配置字典text',
    query_dict_field    varchar(100)         null comment '查询配置字典code',
    query_dict_table    varchar(500)         null comment '查询配置字典table',
    query_show_type     varchar(50)          null comment '查询显示控件',
    query_config_flag   varchar(3)           null comment '是否启用查询配置1是0否',
    query_valid_type    varchar(50)          null comment '查询字段校验类型',
    query_must_input    varchar(3)           null comment '查询字段是否必填1是0否',
    sort_flag           varchar(3)           null comment '是否支持排序1是0否'
)
    charset = utf8;

create index idx_ocf_cgform_head_id
    on `pkpm-bureau`.onl_cgform_field (cgform_head_id);

create index inex_table_id
    on `pkpm-bureau`.onl_cgform_field (cgform_head_id);

