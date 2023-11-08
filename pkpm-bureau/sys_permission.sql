create table `pkpm-bureau`.sys_permission
(
    id                   varchar(32)             not null comment '主键id'
        primary key,
    parent_id            varchar(32)             null comment '父id',
    name                 varchar(100)            null comment '菜单标题',
    url                  varchar(255)            null comment '路径',
    component            varchar(255)            null comment '组件',
    component_name       varchar(100)            null comment '组件名字',
    redirect             varchar(255)            null comment '一级菜单跳转地址',
    menu_type            int                     null comment '菜单类型(0:一级菜单; 1:子菜单:2:按钮权限)',
    perms                varchar(255)            null comment '菜单权限编码',
    perms_type           varchar(10) default '0' null comment '权限策略1显示2禁用',
    sort_no              double(8, 2)            null comment '菜单排序',
    always_show          tinyint(1)              null comment '聚合子路由: 1是0否',
    icon                 varchar(100)            null comment '菜单图标',
    is_route             tinyint(1)  default 1   null comment '是否路由菜单: 0:不是  1:是（默认值1）',
    is_leaf              tinyint(1)              null comment '是否叶子节点:    1:是   0:不是',
    keep_alive           tinyint(1)              null comment '是否缓存该页面:    1:是   0:不是',
    hidden               int(2)      default 0   null comment '是否隐藏路由: 0否,1是',
    hide_tab             int(2)                  null comment '是否隐藏tab: 0否,1是',
    description          varchar(255)            null comment '描述',
    create_by            varchar(32)             null comment '创建人',
    create_time          datetime                null comment '创建时间',
    update_by            varchar(32)             null comment '更新人',
    update_time          datetime                null comment '更新时间',
    del_flag             int(1)      default 0   null comment '删除状态 0正常 1已删除',
    rule_flag            int(3)      default 0   null comment '是否添加数据权限1是0否',
    status               varchar(2)              null comment '按钮权限状态(0无效1有效)',
    internal_or_external tinyint(1)              null comment '外链菜单打开方式 0/内部打开 1/外部打开',
    workflow_flag        int(1)                  null comment '是否关联工作流：0：不是 1：是',
    workflow_keys        varchar(400)            null comment '工作流定义Key',
    form_component       varchar(255)            null comment '表单组件'
)
    comment '菜单权限表' charset = utf8;

create index idx_sp_del_flag
    on `pkpm-bureau`.sys_permission (del_flag);

create index idx_sp_hidden
    on `pkpm-bureau`.sys_permission (hidden);

create index idx_sp_is_leaf
    on `pkpm-bureau`.sys_permission (is_leaf);

create index idx_sp_is_route
    on `pkpm-bureau`.sys_permission (is_route);

create index idx_sp_menu_type
    on `pkpm-bureau`.sys_permission (menu_type);

create index idx_sp_parent_id
    on `pkpm-bureau`.sys_permission (parent_id);

create index idx_sp_sort_no
    on `pkpm-bureau`.sys_permission (sort_no);

create index idx_sp_status
    on `pkpm-bureau`.sys_permission (status);

create index index_menu_hidden
    on `pkpm-bureau`.sys_permission (hidden);

create index index_menu_status
    on `pkpm-bureau`.sys_permission (status);

create index index_menu_type
    on `pkpm-bureau`.sys_permission (menu_type);

create index index_prem_del_flag
    on `pkpm-bureau`.sys_permission (del_flag);

create index index_prem_is_leaf
    on `pkpm-bureau`.sys_permission (is_leaf);

create index index_prem_is_route
    on `pkpm-bureau`.sys_permission (is_route);

create index index_prem_pid
    on `pkpm-bureau`.sys_permission (parent_id);

create index index_prem_sort_no
    on `pkpm-bureau`.sys_permission (sort_no);

