create table `pkpm-bureau`.qrtz_triggers
(
    SCHED_NAME     varchar(120) not null,
    TRIGGER_NAME   varchar(200) not null,
    TRIGGER_GROUP  varchar(200) not null,
    JOB_NAME       varchar(200) not null,
    JOB_GROUP      varchar(200) not null,
    DESCRIPTION    varchar(250) null,
    NEXT_FIRE_TIME bigint(13)   null,
    PREV_FIRE_TIME bigint(13)   null,
    PRIORITY       int          null,
    TRIGGER_STATE  varchar(16)  not null,
    TRIGGER_TYPE   varchar(8)   not null,
    START_TIME     bigint(13)   not null,
    END_TIME       bigint(13)   null,
    CALENDAR_NAME  varchar(200) null,
    MISFIRE_INSTR  smallint(2)  null,
    JOB_DATA       blob         null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint qrtz_triggers_ibfk_1
        foreign key (SCHED_NAME, JOB_NAME, JOB_GROUP) references `pkpm-bureau`.qrtz_job_details (SCHED_NAME, JOB_NAME, JOB_GROUP)
)
    comment 'InnoDB free: 504832 kB; (`SCHED_NAME` `JOB_NAME` `JOB_GROUP`' charset = utf8;

create index SCHED_NAME
    on `pkpm-bureau`.qrtz_triggers (SCHED_NAME, JOB_NAME, JOB_GROUP);

