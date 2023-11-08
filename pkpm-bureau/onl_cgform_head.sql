create table `pkpm-bureau`.onl_cgform_head
(
    id                   varchar(32)                     not null comment '主键ID'
        primary key,
    table_name           varchar(50)                     not null comment '表名',
    table_type           int                             not null comment '表类型: 0单表、1主表、2附表',
    table_version        int         default 1           null comment '表版本',
    table_txt            varchar(200)                    not null comment '表说明',
    is_checkbox          varchar(5)                      not null comment '是否带checkbox',
    is_db_synch          varchar(20) default 'N'         not null comment '同步数据库状态',
    is_page              varchar(5)                      not null comment '是否分页',
    is_tree              varchar(5)                      not null comment '是否是树',
    id_sequence          varchar(200)                    null comment '主键生成序列',
    id_type              varchar(100)                    null comment '主键类型',
    query_mode           varchar(10)                     null comment '查询模式',
    relation_type        int                             null comment '映射关系 0一对多  1一对一',
    sub_table_str        varchar(1000)                   null comment '子表',
    tab_order_num        int                             null comment '附表排序序号',
    tree_parent_id_field varchar(50)                     null comment '树形表单父id',
    tree_id_field        varchar(50)                     null comment '树表主键字段',
    tree_fieldname       varchar(50)                     null comment '树开表单列字段',
    form_category        varchar(50) default 'bdfl_ptbd' not null comment '表单分类',
    form_template        varchar(50)                     null comment 'PC表单模板',
    form_template_mobile varchar(50)                     null comment '表单模板样式(移动端)',
    scroll               int(3)      default 0           null comment '是否有横向滚动条',
    copy_version         int                             null comment '复制版本号',
    copy_type            int(3)      default 0           null comment '复制表类型1为复制表 0为原始表',
    physic_id            varchar(32)                     null comment '原始表ID',
    ext_config_json      varchar(1000)                   null comment '扩展JSON',
    update_by            varchar(32)                     null comment '修改人',
    update_time          datetime                        null comment '修改时间',
    create_by            varchar(32)                     null comment '创建人',
    create_time          datetime                        null comment '创建时间',
    theme_template       varchar(50)                     null comment '主题模板',
    is_des_form          varchar(2)                      null comment '是否用设计器表单',
    des_form_code        varchar(50)                     null comment '设计器表单编码',
    low_app_id           varchar(32)                     null comment '关联的应用ID',
    constraint index_onlineform_table_name
        unique (table_name)
)
    charset = utf8;

create index idx_och_cgform_head_id
    on `pkpm-bureau`.onl_cgform_head (table_name);

create index idx_och_form_template_mobile
    on `pkpm-bureau`.onl_cgform_head (form_template_mobile);

create index idx_och_table_name
    on `pkpm-bureau`.onl_cgform_head (form_template);

create index idx_och_table_version
    on `pkpm-bureau`.onl_cgform_head (table_version);

create index index_form_templdate
    on `pkpm-bureau`.onl_cgform_head (form_template);

create index index_onlineform_table_version
    on `pkpm-bureau`.onl_cgform_head (table_version);

create index index_templdate_mobile
    on `pkpm-bureau`.onl_cgform_head (form_template_mobile);

