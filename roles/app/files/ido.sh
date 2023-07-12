#!/bin/bash

# Date: 17/5/2022
# author: Chaos
export PATH=$HOME/bin:/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
source /etc/profile && source ~/.bash_profile
# Define variables
LSB=/usr/bin/lsb_release
RED='\033[0;31m'
Yl='\033[1;33m'
BIYellow='\033[1;93m'
NC='\033[0m' # No Color


# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White
White_On_Blue='\033[1m\033[44;37m' #White_On_Blue
White_On_Red='\033[1m\033[41;37m' #White_On_Red
Yellow_On_Pink='\033[1m\033[45;33m' #Yellow_On_Pink
# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White



# Purpose: Display pause prompt
# $1-> Message (optional)

##
which_cmd() {
    which "${1}" 2>/dev/null || \
        command -v "${1}" 2>/dev/null
}
fatal() {
    printf >&2 "${TPUT_BGRED}${TPUT_WHITE}${TPUT_BOLD} ABORTED ${TPUT_RESET} ${*} \n\n"
    exit 1
}
check_cmd() {
    which_cmd "${1}" >/dev/null 2>&1 && return 0
    return 1
}
setup_terminal() {
    TPUT_RESET=""
    TPUT_BLACK=""
    TPUT_RED=""
    TPUT_GREEN=""
    TPUT_YELLOW=""
    TPUT_BLUE=""
    TPUT_PURPLE=""
    TPUT_CYAN=""
    TPUT_WHITE=""
    TPUT_BGBLACK=""
    TPUT_BGRED=""
    TPUT_BGGREEN=""
    TPUT_BGYELLOW=""
    TPUT_BGBLUE=""
    TPUT_BGPURPLE=""
    TPUT_BGCYAN=""
    TPUT_BGWHITE=""
    TPUT_BOLD=""
    TPUT_DIM=""
    TPUT_UNDERLINED=""
    TPUT_BLINK=""
    TPUT_INVERTED=""
    TPUT_STANDOUT=""
    TPUT_BELL=""
    TPUT_CLEAR=""

    # Is stderr on the terminal? If not, then fail
    test -t 2 || return 1

    if check_cmd tput
    then
        if [ $(( $(tput colors 2>/dev/null) )) -ge 8 ]
        then
            # Enable colors
            TPUT_RESET="$(tput sgr 0)"
            TPUT_BLACK="$(tput setaf 0)"
            TPUT_RED="$(tput setaf 1)"
            TPUT_GREEN="$(tput setaf 2)"
            TPUT_YELLOW="$(tput setaf 3)"
            TPUT_BLUE="$(tput setaf 4)"
            TPUT_PURPLE="$(tput setaf 5)"
            TPUT_CYAN="$(tput setaf 6)"
            TPUT_WHITE="$(tput setaf 7)"
            TPUT_BGBLACK="$(tput setab 0)"
            TPUT_BGRED="$(tput setab 1)"
            TPUT_BGGREEN="$(tput setab 2)"
            TPUT_BGYELLOW="$(tput setab 3)"
            TPUT_BGBLUE="$(tput setab 4)"
            TPUT_BGPURPLE="$(tput setab 5)"
            TPUT_BGCYAN="$(tput setab 6)"
            TPUT_BGWHITE="$(tput setab 7)"
            TPUT_BOLD="$(tput bold)"
            TPUT_DIM="$(tput dim)"
            TPUT_UNDERLINED="$(tput smul)"
            TPUT_BLINK="$(tput blink)"
            TPUT_INVERTED="$(tput rev)"
            TPUT_STANDOUT="$(tput smso)"
            TPUT_BELL="$(tput bel)"
            TPUT_CLEAR="$(tput clear)"
        fi
    fi

    return 0
}
setup_terminal || echo >/dev/null
progress() {
    echo >&2 " --- ${TPUT_DIM}${TPUT_BOLD}${*}${TPUT_RESET} --- "
}

run_ok() {
    printf >&2 "${TPUT_BGGREEN}${TPUT_WHITE}${TPUT_BOLD} OK ${TPUT_RESET} ${*} \n\n"
}

run_failed() {
    printf >&2 "${TPUT_BGRED}${TPUT_WHITE}${TPUT_BOLD} FAILED ${TPUT_RESET} ${*} \n\n"
}

ESCAPED_PRINT_METHOD=
printf "%q " test >/dev/null 2>&1
[ $? -eq 0 ] && ESCAPED_PRINT_METHOD="printfq"
escaped_print() {
    if [ "${ESCAPED_PRINT_METHOD}" = "printfq" ]
    then
        printf "%q " "${@}"
    else
        printf "%s" "${*}"
    fi
    return 0
}

run_logfile="/dev/null"
run() {
    local user="${USER--}" dir="${PWD}" info info_console

    if [ "${UID}" = "0" ]
        then
        info="[root ${dir}]# "
        info_console="[${TPUT_DIM}${dir}${TPUT_RESET}]# "
    else
        info="[${user} ${dir}]$ "
        info_console="[${TPUT_DIM}${dir}${TPUT_RESET}]$ "
    fi

    printf >> "${run_logfile}" "${info}"
    escaped_print >> "${run_logfile}" "${@}"
    printf >> "${run_logfile}" " ... "

    printf >&2 "${info_console}${TPUT_BOLD}${TPUT_YELLOW}"
    escaped_print >&2 "${@}"
    printf >&2 "${TPUT_RESET}\n"

    "${@}"

    local ret=$?
    if [ ${ret} -ne 0 ]
        then
        run_failed
        printf >> "${run_logfile}" "FAILED with exit code ${ret}\n"
    else
        run_ok
        printf >> "${run_logfile}" "OK\n"
    fi

    return ${ret}
}
umask 022

[ -z "${UID}" ] && UID="$(id -u)"

# ---------------------------------------------------------------------------------------------------------------------


## User Variables
# w_ports=$(cat ~/war/var/web-*/bin/tomcat.sh | grep TOMCAT_PORT_LISTEN= | cut -d = -f2)
# for i in $w_ports ;do echo $i `curl -w '%{http_code}\n'  -o /dev/null --connect-timeout 3 -m 3 -s -L 127.0.0.1:$i`  ;done
OS_VERSION=`cat /etc/redhat-release | grep -oP '(?<= )[0-9]+(?=\.)'`
sname=`hostname -s`
HOST_IP=`ip addr | grep inet | grep -v inet6 | grep -v 127.0.0.1 | awk '{print $2}' | awk -F '/' '{print $1}' | head -1`
DNS_IPs=($(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}' | awk '{for(i=1;i<=NF;i++){if(last[$i]!=NR)a[$i]++;last[$i]=NR}}END{for(i in a)print i}' ))
human_time_stamp=$(date +%Y%m%d%H%M%S)
rhost='oper@175.6.21.209'
rdest='/home/oper/'
rport='8822'

### Configuration
#####################################################################

# Environment variables
[ -z "${LOG_LEVEL}" ]       && LOG_LEVEL="6" # 7 = debug, 0 = emergency
[ -z "${NS_ENABLE}" ]       && NS_ENABLE="yes" # Set to no to disable
[ -z "${NS_TESTDOMAIN}" ]   && NS_TESTDOMAIN="baidu.com" # Use this to determine if NS is healthy
[ -z "${NS_1}" ]            && NS_1="172.16.1.70" # Primary Nameserver (172.16.0.23 for Amazon EC2). You need to set this yourself
[ -z "${NS_2}" ]            && NS_2="114.114.114.114" # Secundary Nameserver: Google
[ -z "${NS_3}" ]            && NS_3="119.29.29.29" # Tertiary Nameserver: Level3
[ -z "${NS_TIMEOUT}" ]      && NS_TIMEOUT="3" # http://linux.die.net/man/5/resolv.conf
[ -z "${NS_ATTEMPTS}" ]     && NS_ATTEMPTS="1" # http://linux.die.net/man/5/resolv.conf
[ -z "${NS_WRITEPROTECT}" ] && NS_WRITEPROTECT="no" # Use this to write-protect /etc/resolv.conf
[ -z "${NS_FILE}" ]         && NS_FILE="/etc/resolv.conf" # Where to write resolving conf
[ -z "${NS_SEARCH}" ]       && NS_SEARCH="" # Domain to search hosts in (compute-1.internal for Amazon EC2)

# Set magic variables for current FILE & DIR
__DIR__="$(cd "$(dirname "${0}")"; echo $(pwd))"
__FILE__="${__DIR__}/$(basename "${0}")"

function _fmt ()      {
  color_ok="\x1b[32m"
  color_bad="\x1b[31m"

  color="${color_bad}"
  if [ "${1}" = "debug" ] || [ "${1}" = "info" ] || [ "${1}" = "notice" ]; then
    color="${color_ok}"
  fi

  color_reset="\x1b[0m"
  if [ "${TERM}" != "xterm" ] || [ -t 1 ]; then
    # Don't use colors on pipes or non-recognized terminals
    color=""; color_reset=""
  fi
  echo -e "$(date  +"%Y-%m-%d %H:%M:%S CST") ${color}$(printf "[%9s]" ${1})${color_reset}";
}
function emergency () {                             echo "$(_fmt emergency) ${@}" || true; exit 1; }
function alert ()     { [ "${LOG_LEVEL}" -ge 1 ] && echo "$(_fmt alert) ${@}" || true; }
function critical ()  { [ "${LOG_LEVEL}" -ge 2 ] && echo "$(_fmt critical) ${@}" || true; }
function error ()     { [ "${LOG_LEVEL}" -ge 3 ] && echo "$(_fmt error) ${@}" || true; }
function warning ()   { [ "${LOG_LEVEL}" -ge 4 ] && echo "$(_fmt warning) ${@}" || true; }
function notice ()    { [ "${LOG_LEVEL}" -ge 5 ] && echo "$(_fmt notice) ${@}" || true; }
function info ()      { [ "${LOG_LEVEL}" -ge 6 ] && echo "$(_fmt info) ${@}" || true; }
function debug ()     { [ "${LOG_LEVEL}" -ge 7 ] && echo "$(_fmt debug) ${@}" || true; }

function ns_healthy() {
  local nserver="${1}"
  local domain="${2}"

  result="$(dig @${nserver} +time=3 +tries=1 +short "${domain}")"
  exitcode="${?}"
  if [ -z "${result}" ] || [ "${exitcode}" -ne 0 ]; then
    echo "no"
  else
    echo "yes"
  fi
}

dnsping(){
### Validation (decide what's required for running your script and error out)
#####################################################################

[ "${NS_ENABLE}" != "yes" ] && info "$(basename "${__FILE__}") is not enabled. " && exit 0
[ -z "${LOG_LEVEL}" ] && emergency "Cannot continue without LOG_LEVEL. "
[ -z "${NS_1}" ] && emergency "Cannot continue without NS_1. "
[ -z "${NS_2}" ] && emergency "Cannot continue without NS_2. "
[ -z "${NS_3}" ] && emergency "Cannot continue without NS_3. "


### Runtime
#####################################################################

set -ue

if [ "$(ns_healthy "${NS_1}" "${NS_TESTDOMAIN}")" = "yes" ]; then
  use_server="${NS_1}"
  use_level="primary"
elif [ "$(ns_healthy "${NS_2}" "${NS_TESTDOMAIN}")" = "yes" ]; then
  use_server="${NS_2}"
  use_level="secondary"
elif [ -n "${NS_3}" ] && [ "$(ns_healthy "${NS_3}" "${NS_TESTDOMAIN}")" = "yes" ]; then
  use_server="${NS_3}"
  use_level="tertiary"
else
  # 3 misfires. Must be this box is down, or misconfiguration
  emergency "Tried ${NS_1}, ${NS_2}, ${NS_3} but no nameserver was found healthy. Network ok?"
fi


info "Best nameserver is ${use_level} (${use_server})"

# Build new config (without comments!)
resolvconf="nameserver ${use_server}
nameserver ${NS_1}
nameserver ${NS_2}
nameserver ${NS_3}
options timeout:${NS_TIMEOUT} attempts:${NS_ATTEMPTS}"
# Optionally add search parameter
[ -n "${NS_SEARCH}" ] && resolvconf="${resolvconf}
search ${NS_SEARCH}"

# Load current config (without comments)
current="$(cat "${NS_FILE}" |egrep -v '^#')" || true

# Is the config updated?
if [ "${resolvconf}" != "${current}" ]; then
  curdate="$(date -u +"%Y%m%d%H%M%S")"
  cp "${NS_FILE}"{,.bak-${curdate}}
  [ "${NS_WRITEPROTECT}" = "yes" ] && chattr -i "${NS_FILE}" || true
  resolvconf="# Written by ${__FILE__} @ ${curdate}
${resolvconf}"
  tmpfile="${NS_FILE}.tmp"
  echo "$resolvconf" > $tmpfile
  # paranoid check if file has changed since written
  if diff $tmpfile <(echo "$resolvconf"); then
    # atomic copy
    mv $tmpfile $NS_FILE
  else
    emergency "Temp file ${tempfile} changed since creation"
  fi
  [ "${NS_WRITEPROTECT}" = "yes" ] && chattr +i "${NS_FILE}"

  # Folks will want to know about this
  msg="I changed ${NS_FILE} to use ${use_level} (${use_server})"
  if [ "${NS_1}" = "${use_server}"  ]; then
    notice "${msg}"
  else
    emergency "${msg}"
  fi
fi

info "No need to change ${NS_FILE}"

}
function show_process () {
    ps -ef | grep ${1} | grep -vw vim | grep -vE 'grep|tail|less|more'
}
function show_lstart () {
    # ps -eo lstart,cmd | grep ${1} | grep -vw vim | grep -vE 'grep|tail|less|more' | cut -d \  -f1-5
    ps -eo lstart,pid,cmd | grep ${1} | grep -vw vim | grep -vE 'grep|tail|less|more' | cut -d \  -f1-5
}


formatProcess(){
    PROCESS="$1"
    if [ "${PROCESS}" = "filebeat" ]; then
         /etc/init.d/filebeat status 
    elif [ "${PROCESS}" = "logstash" ]; then
         /etc/init.d/logstash status
    elif [ "${PROCESS}" = "kafka" ]; then
         ps -ef | grep java |grep kafka | grep -v grep > /dev/null 2>&1
    else
        ps -deaf | grep "${PROCESS}" | grep -vw vim | grep -vE 'grep|tail|less|more' > /dev/null 2>&1
    fi
    RETVAL="$?"
    if [ "${RETVAL}" == 0 ]; then
        PROCESS_PID=$(ps -ef | grep ${PROCESS} | grep -vw vim | grep -vE 'grep|tail|less|more' | awk '{print $2}')
    fi
}

# curl -X POST -F port=${port22} -F port=${port13021} -F port=${port13022} -F port=${port13023} -F port=${port13024} -F ip=${ip} http://58.67.212.246:8181/nchostapi
getMonitorProcess(){
    config_file="${HOME}/monitorTarget.cfg"
    if [ -f "$config_file" ]; then
        monitorList=$(cat "$config_file")
    else
        monitorList=$(curl --speed-time 10 --speed-limit 1 --connect-timeout 5 -m 10  "http://192.168.11.163:18444/getMonitorProcess?ip=${HOST_IP}" 2>/dev/null)
        test "$?" != "0" && alert "could not get the monitor List" && exit 4
    fi
}

Report(){
    if [ "${1}" != "" ]; then
        if [ "$1" = "get" ]; then
            reportURL="https://midadmin.med.haici.com/api/archadmin/elkmonitor/uploadRunningError?ip=${2}&serverType=${3}&errorTimestamp=${4}"
            # reportURL="http://192.168.111.115:10003/api/archadmin/elkmonitor/uploadRunningError?ip=${2}&serverType=${3}&errorTimestamp=${4}"
            curl --speed-time 10 --speed-limit 1 --connect-timeout 5 -m 10 ${reportURL}
        elif [ "$1" = "post" ]; then
             echo "post"
        else
            echo "only support get/post."
            exit 1
        fi
    else
        echo "get or post"
        exit 2
    fi
}
monitorAndReport(){
    getMonitorProcess
    for col in ${monitorList}; do
        formatProcess ${col}
        case "${RETVAL}" in
            # 0)  RunningStatus='started'; StartTime=`show_lstart ${col}` ; printf "%-20s\t%-12s\t%-13s\t%-20s\n"  ${PROCESS} ${PROCESS_PID} $RunningStatus "$StartTime";;
            # 0)  RunningStatus='started'; StartTime=`show_lstart ${col}` ; for p in ${PROCESS_PID} ;do info "${PROCESS} $RunningStatus" ;printf "%-20s\t%-12s\t%-13s\t%-20s\n"  ${PROCESS} ${p} $RunningStatus "`show_lstart ${p}`" ;done ;;
            0)  RunningStatus='started'; StartTime=`show_lstart ${col}` ; info "${PROCESS} $RunningStatus"  ;;
            *)  alert "${col} is dead" ; Report get "${HOST_IP}" "${col}" $(date +%s%3N) ;;
        esac
    done
    
}
rmlogtar(){
    # rm the local tar.gz
    local nowtime=`date +%F`
    ssh -p ${rport} ${rhost} "/usr/bin/find ${rdest} -mtime -1 -type f" > /tmp/rmf-${nowtime}.txt
    for i in $(cat /tmp/rmf-${nowtime}.txt | grep `hostname`); do f=`basename "$i"`&& cd /logs/;rm -fv $f ;done
}
backup(){
    beforeDay=${1:-1}
    echo "start logrotate beforeDay ${beforeDay}"
    local btime=`date +"%Y-%m-%d" --date="-${beforeDay} day"`
    local hname=`hostname`
    # local rdf3t=`ssh -p ${rport} hcit@172.16.11.40 "bash ~/bin/df3t"`
    echo "`date "+%F@%H:%M:%S"` ${rhost}:${rdest} disk free is ${rdf3t}G"
    echo "...... Start  Clear /tmp/logs && /home/prtg/logs && catalina.out.20*................"
    /bin/rm -fvr /tmp/logs
    /bin/rm -fvr /home/prtg/logs
    logrotateListFile='/tmp/bk.txt'
    find /logs -name "catalina.out.20*" -exec rm -fv {} \;
    find /logs -name "*.hprof" -exec rm -fv {} \;
    echo ....................... Start  $btime ....................................
    find /logs -name "log.out.${btime}*" > ${logrotateListFile}
    find /logs -name "*${btime}*.out"  >> ${logrotateListFile}
    find /logs -name "facade.out.${btime}*" >> ${logrotateListFile}
    find /logs -name "error.out.${btime}*"  >> ${logrotateListFile}
    find /logs -name "monitorlog.out.${btime}*" >> ${logrotateListFile}
    find /logs -name "monitordetaillog.out.${btime}*" >> ${logrotateListFile}
    find /logs -name "access_log.${btime}.*.log" >> ${logrotateListFile}
    find /logs -name "access_log.${btime}.json" >> ${logrotateListFile}
    find /logs -name "accesslog.${btime}.log" >> ${logrotateListFile}
    find /logs -name "log.out.${btime}.*.gz" >> ${logrotateListFile}
    echo -e "\n"
    echo -e "\n"
    echo -e "\n"
    echo ................Here is the listinfo ............
    cat ${logrotateListFile}
    echo ................Here is the listinfo ............
    echo -e "\n"
    echo -e "\n"
    echo -e "\n"
    # find /logs -name catalina.out -exec tee {} \; </dev/null
    find /logs -name catalina.out | xargs  truncate -s 0
    if [ -f /logs/${hname}_idobklog_${btime}.tar.gz ]
    then
        echo -e "\n"
        echo -e "####################### $btime is already exist!! ####################################"
        ls -al /logs/${hname}_idobklog_${btime}.tar.gz
        du -sh /logs/${hname}_idobklog_${btime}.tar.gz
        echo -e "####################### $btime is already exist!! ####################################"
        echo -e "\n"

    else

        echo -e "\n"
        tar -T ${logrotateListFile} -czvf /logs/${hname}_idobklog_${btime}.tar.gz
        echo "Backup to ${rhost}:${rdest}"
        /usr/bin/scp -P ${rport} /logs/${hname}_idobklog_${btime}.tar.gz ${rhost}:${rdest} && rm -f /logs/${hname}_idobklog_${btime}.tar.gz
        echo Start..................rming..........................
        for i in `cat ${logrotateListFile}`;do rm -fv ${i} ;done
        echo -e "####################### $btime is Done!! ####################################"
        echo -e "\n"
    fi
}
syntime(){
    # syn time (run_user=root)
    if [ "${UID}" = "0" ]
    then
        /bin/cp  -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
        timeServer=${1:-time.apple.com}
        echo syn time #with ${timeServer}
        nowTServer=`crontab -l | grep ntpdate | tail -1 | awk '{print $NF}' `
        if which ntpdate >/dev/null 2>&1 ;then
            if [ "${1}" = "" ] ; then
                run sudo -u root /usr/sbin/ntpdate -u time.apple.com
            elif [ "$1" = "set" ];then
                shift
                if [ "${1}" = "" ];then
                    echo "Please specify a time server!!"
                elif [ "$1" = "$nowTServer" ];then
                    echo "No need to change!"
                else
                    run echo New ntp server is: ${1}
                fi
            else
                run sudo -u root /usr/sbin/ntpdate -u ${1}
            fi
        else
            echo "ntpdate is not installed!!Contact the IT Group."
        fi
    else
        echo "Please use root to run this function"
    fi
}

syndev(){
    ## syn war to dev 145 (run_user=webhis)
    for i in `find /home/webhis/war/var/web-*/webapps/ -name ROOT.war | grep -v insurance`; do rsync -avSH -e 'ssh -p 45022' $i webhis@220.168.91.141:$i; done

    ## syn war to dev 146 (run_user=dubbo)
    for i in `ls /home/dubbo/service/*-center/*.jar | awk -F "/" '{print $5}'`; do rsync -avSH -e 'ssh -p 46022' /home/dubbo/service/$i/*.jar dubbo@220.168.91.141:/home/dubbo/service/$i; done
    sleep 120
    for i in `ls /home/dubbo/service/*-center/*.jar | awk -F "/" '{print $5}'`; do rsync -avSH -e 'ssh -p 46022' /home/dubbo/service/$i/lib/ dubbo@220.168.91.141:/home/dubbo/service/$i/lib/; done
}
clearlog(){
    #(run_user=root)
    # find /logs -name monitorlog.out -exec tee {} \; </dev/null
    find /logs -name monitorlog.out -o -name monitordetaillog.out -o -name catalina.out | xargs  truncate -s 0
    find /home/*/logs/rocketmqlogs -name "rocketmq_client.log*" | xargs  truncate -s 0
    # find /logs -name monitordetaillog.out -exec tee {} \; </dev/null
    # find /logs -name catalina.out -exec tee {} \; </dev/null

}
synlogtar(){
    #(run_user=root)
    # todo:传参指定备份目标服务器以及目录
    run find /logs -name "`hostname`*.tar.gz" -type f -exec scp -P ${rport} {} ${rhost}:${rdest} \; 
}

[ -z "${UID}" ] && UID="$(id -u)"
# ignore CTRL+C, CTRL+Z and quit singles using the trap
#trap '' SIGINT SIGQUIT SIGTSTP

# main logic
if [ $# -gt 0 ]; then
#    while [ "$1" != "" ]; do
     case $1 in
        backup )
                                shift
                                softname=backup
                                $softname ${@}
                                ;;
        -mr | monitorAndReport )
                                #shift
                                operation='monitorAndReport'
                                ${operation}
                                ;;
        rmlogtar  )
                                softname=rmlogtar
                                $softname
                                ;;
        clearlog  )
                                softname=clearlog
                                $softname
                                ;;
        synlogtar  )
                                #shift
                                # operation=${@}
                                softname=synlogtar
                                $softname
                                ;;
        dnsping )
                                #shift
                                softname=dnsping
                                $softname
                                ;;
        -t | syntime )
                                shift
                                softname=syntime
                                $softname ${1}
                                ;;
        -h | help )
                                usage
                                exit
                                ;;
        * )
                                service_Operate ${@}

     esac
#      shift
#    done

else
    usage
fi