create table `pkpm-bureau`.qrtz_paused_trigger_grps
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_GROUP varchar(200) not null,
    primary key (SCHED_NAME, TRIGGER_GROUP)
)
    charset = utf8;

