create table `pkpm-bureau`.qrtz_cron_triggers
(
    SCHED_NAME      varchar(120) not null,
    TRIGGER_NAME    varchar(200) not null,
    TRIGGER_GROUP   varchar(200) not null,
    CRON_EXPRESSION varchar(200) not null,
    TIME_ZONE_ID    varchar(80)  null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_cron_triggers_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references `pkpm-bureau`.qrtz_triggers (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
)
    comment 'InnoDB free: 504832 kB; (`SCHED_NAME` `TRIGGER_NAME` `TRIGGE' charset = utf8;

