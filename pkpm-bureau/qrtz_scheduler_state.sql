create table `pkpm-bureau`.qrtz_scheduler_state
(
    SCHED_NAME        varchar(120) not null,
    INSTANCE_NAME     varchar(200) not null,
    LAST_CHECKIN_TIME bigint(13)   not null,
    CHECKIN_INTERVAL  bigint(13)   not null,
    primary key (SCHED_NAME, INSTANCE_NAME)
)
    charset = utf8;

