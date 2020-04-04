#!/bin/bash

#author liujinxi@sogou-inc.com
#date 20200211
#example 从hadoop上获取novel_tag_dict，推到LDS机器上

date +"%Y%m%d %H:%M:%D"


YYYYMMDD=`date -d "1 day ago" +%Y%m%S`
hosts_dir="/search/controller/hosts"
client="/opt/hadoop-client/hadoop-Saturn/hadoop/bin/hadoop"
remote_dir="/bigdata/public/kdb/booklist/"
local_dir="/search/controller/task/lds_day_flow/data/novel_tag_dict"
local_tmp_dir="/search/controller/task/lds_day_flow/data/novel_tag_dict/tmp"
file_list="novel_tag_dict.dat novel_tag_dict.dat.md5"


function send_sms 
{
    context=$1
    sms_head="Union/Flow/LDS"
    /opt/monitor/sendsms.sh "${sms_head}[$context]"

}

function check_data
{
    
    $client fs -ls ${remote_dir}/${YYYYMMDD}/done
    if [ $? -ne 0 ]
    then
        send_sms "wangmeng_booklist.txt的done不存在"
        exit 1
    fi

}

function get_data
{
    ${client} fs -get ${remote_dir}/${YYYYMMDD}/wangmeng_booklist.txt ${local_tmp_dir}/novel_tag_dict.dat
    if [ $? -ne 0 ]
    then
        send_sms "获取wangmeng_booklist.txt失败"
        exit 1
    fi
    mdsum ${local_tmp_dir}/novel_tag_dict.dat ${local_tmp_dir}/novel_tag_dict.dat.md5
    mv ${local_tmp_dir}/* ${local_dir}
}

function deliver_data
{
    deliver_dir="/search/odin/LDS/data/dicts/novel_tag_dir/"
    sync_flag=0
    error_list=""
    for ip in `cat ${hosts_dir}/hosts.lds|grep -v "#"`
	do
        ssh ${ip} "mkdir -p ${deliver_dir}"
        sync_flag=0
        error_list=""
        for file in ${file_list}
        do
            rsync -L --bwlimit=70000 ${local_dir}/${file} ${ip}::root${deliver_dir}
            if [ $? -ne 0 ]
            then
                sync_flag=1
                error_list="${file},${error_list}"
                echo "deliver data to ${deliver_dir} error"
            fi
        done
        if [ ${sync_flag} -ne 0 ]
        then
            sendsms "推送文件到${ip}失败 ${error_list}"
        fi
    done

}

check_data
get_data
deliver_data

date +"%Y%m%d %H:%M:%S"
