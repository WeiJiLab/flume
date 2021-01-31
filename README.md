# flume

## Build
### Args
|Arg Name|MUST Provided|Description|
|---|:---:|---|
|APK_MIRROR_SOURCE_URL|no|apk registry mirror domain. example: official registry is 'dl-cdn.alpinelinux.org'. If not provided. official registry will be used|
|DOWNLOAD_SOURCE|no|flume download site prefix before version segement. example: official site is 'http://www.apache.org/dyn/closer.lua/flume'. If not provided, official site will be used|
|FLUME_VERSION|yes|flume version string. example: '1.9.0'.|

## Volumes
|Container|Descrption|
|---|---|
|/opt/flume/conf|Configurations of flume. see templates in conf foldier of flume|
|/opt/flume/exlib|Place your lib files for source, sink, interception here|
|/etc/nginx/conf.d/default.conf|Your nginx conf file|
