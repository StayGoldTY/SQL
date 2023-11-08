create table `pkpm-bureau`.sys_attach_chunk
(
    ID                    varchar(36)            not null
        primary key,
    CREATE_BY             varchar(50)            null,
    CREATE_TIME           datetime               null,
    UPDATE_BY             varchar(50)            null,
    UPDATE_TIME           datetime               null,
    SYS_ORG_CODE          varchar(64)            null,
    CHUNK_GUID            varchar(64)            null,
    FILE_MD5              varchar(64)            null,
    FILE_NAME             varchar(64)            null,
    CHUNK_SIZE            int                    null,
    CHUNK_COUNT           int                    null,
    CHUNK_INDEX           int                    null,
    CHUNK_FILE_PATH       varchar(500)           null,
    UPLOAD_OSS_ID         varchar(64)            null,
    UPLOAD_OSS_CHUNK_INFO varchar(64)            null,
    CHUNK_TYPE            varchar(64)            null,
    MERGE_STATUS          int                    null,
    IZ_DELETE             varchar(1) default '0' null
);

