create table `pkpm-bureau`.qrtz_simprop_triggers
(
    SCHED_NAME    varchar(120)   not null,
    TRIGGER_NAME  varchar(200)   not null,
    TRIGGER_GROUP varchar(200)   not null,
    STR_PROP_1    varchar(512)   null,
    STR_PROP_2    varchar(512)   null,
    STR_PROP_3    varchar(512)   null,
    INT_PROP_1    int            null,
    INT_PROP_2    int            null,
    LONG_PROP_1   bigint         null,
    LONG_PROP_2   bigint         null,
    DEC_PROP_1    decimal(13, 4) null,
    DEC_PROP_2    decimal(13, 4) null,
    BOOL_PROP_1   varchar(1)     null,
    BOOL_PROP_2   varchar(1)     null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_simprop_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references `pkpm-bureau`.qrtz_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    comment 'InnoDB free: 504832 kB; (`SCHED_NAME` `TRIGGER_NAME` `TRIGGE' charset = utf8;

