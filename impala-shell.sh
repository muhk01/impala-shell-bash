#!/bin/sh

path_query=/opt/script/impala/script/sql_script_input
path_query_temp=/opt/script/impala/script/sql_script_execute

date_min=$1
date_max=$2

path_query_result=/opt/script/impala/result/query1_result

init()
{
  kinit -kt /usr/local/config/keytab/xxxx.keytab xxxx 
}

insert_date()
{
  sed -e "s/{min_date}/$date_min/" -e "s/{max_date}/$date_max/" $path_query > $path_query_temp
}

get_data()
{
  impala-shell -i xxxxx:25003 -k -f $path_query_temp -o $path_query_result -B --output_delimiter "|" --protocol=beeswax
}

init
insert_date
get_data