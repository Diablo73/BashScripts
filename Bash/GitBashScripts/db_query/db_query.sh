#!/bin/bash

declare DB_NAME_MAP
DB_NAME_MAP["0000"]="dbX"
DB_NAME_MAP["0001"]="dbY"
DB_NAME_MAP["0002"]="dbZ"

declare DB_COUNT_MAP
DB_COUNT_MAP["00"]=10
DB_COUNT_MAP["01"]=20
DB_COUNT_MAP["02"]=25

declare TABLE_TYPE_MAP
TABLE_TYPE_MAP["000"]="pay"
TABLE_TYPE_MAP["001"]="refund"

# 2024031600020200173211235467890
# 20240316 0002 02 001 7321 1235467890 (date dbNameIdentifier dbCountIdentifier tableTypeIdentifier shards randomString)
REQUEST_ID="$1"
DB_SHARD_SUBSTRING=$((${REQUEST_ID:17:2} + 0))														# 73
TABLE_SHARD_SUBSTRING=$((${REQUEST_ID:19:2} + 0))													# 21
DB_SHARD=$(expr $DB_SHARD_SUBSTRING % ${DB_COUNT_MAP[${REQUEST_ID:12:2}]})							# 23 = 73 % (DB_COUNT_MAP["02"]=25)
TABLE_SHARD=$(expr $TABLE_SHARD_SUBSTRING % 10)														# 1 = 21 % 10

declare JDBC_URL_MAP
JDBC_URL_MAP["00"]="prod-alpha-cluster-$(printf "%02d $DB_SHARD")-ro-abcdef.amazonaws.com"
JDBC_URL_MAP["01"]="prod-beta-cluster-$(printf "%02d $DB_SHARD")-ro-abcdef.amazonaws.com"
JDBC_URL_MAP["02"]="prod-gamma-cluster-$(printf "%02d $DB_SHARD")-ro-abcdef.amazonaws.com"
# prod-gamma-cluster-00-ro-abcdef.amazonaws.com
# prod-gamma-cluster-01-ro-abcdef.amazonaws.com

DB_NAME=$(DB_NAME_MAP[${REQUEST_ID:8:4}])$DB_SHARD													# dbZ23 = (DB_NAME_MAP["0002"]=dbZ)23
TABLE_TYPE=$(TABLE_TYPE_MAP[${REQUEST_ID:14:3}])													# refund = (TABLE_TYPE_MAP["001"]=refund)

SSH_USER="dev_user"
SSH_PASS="dev@123"
SSH_HOST="127.0.01"
MYSQL_USER="db_user"
MYSQL_PASS="db@321"
MYSQL_HOST=${JDBC_URL_MAP[${REQUEST_ID:12:2}]}														# prod-gamma-cluster-23-ro-abcdef.amazonaws.com

clear

sshpass -p $SSH_PASS ssh -o StrictHostKeyChecking=no $SSH_USER@$SSH_HOST << EOF | tee -a "/Users/ashulgupta/Desktop/db_query_output.txt"

mysql -u $MYSQL_USER -p$MYSQL_PASS -h $MYSQL_HOST

use $DB_NAME;

select '                                                   ';
select '                       order                       ';
select '                                                   ';
select * from ${TABLE_TYPE}_order_$TABLE_SHARD where request_id='$REQUEST_ID' \G;

select '                                                   ';
select '                     meta_data                     ';
select '                                                   ';
select * from ${TABLE_TYPE}_meta_data_$TABLE_SHARD where request_id='$REQUEST_ID' \G;

EOF
