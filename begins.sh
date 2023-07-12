#!/bin/bash

function logger() {
  TIMESTAMP=$(date +'%Y-%m-%d %H:%M:%S')
  case "$1" in
    debug)
      echo -e "$TIMESTAMP \033[36mDEBUG\033[0m $2"
      ;;
    info)
      echo -e "$TIMESTAMP \033[32mINFO\033[0m $2"
      ;;
    warn)
      echo -e "$TIMESTAMP \033[33mWARN\033[0m $2"
      ;;
    error)
      echo -e "$TIMESTAMP \033[31mERROR\033[0m $2"
      ;;
    *)
      ;;
  esac
}


function check_os () {
   if [ -f  /etc/redhat-release ];then
        os=rhel 
    elif [ -f  /etc/kylin-release ];then
        os=kylin

    elif [ -f /etc/openEuler-release ];then
        os=euler
    else
        logger error "Unsupported system"
        exit 2
    fi
}


function create_repo(){

    ping www.baidu.com -c 1 &>/dev/null
    if [ $? -eq 0 ];then
        echo 
    else
        yum clean all &>/dev/null
        mkdir -p /etc/yum.repos.d/bak
        mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak
        cat > /etc/yum.repos.d/web.repo <<EOF
[web]
name=lan repo
baseurl=http://localhost:10000/package/$basearch/$os/
gpgcheck=0
enabled=0
EOF
    fi
}

function start_web_service () {
    if [ -f web ];then
        chmod +x web
        nohup ./web & &>/dev/null
    else
        logger error "The 'web' file does not exist"
        exit 3
    fi
}

function check_package() {
    code=$(curl -o /dev/null -s -w %{http_code} --connect-timeout 1  http://localhost:10000/package/$(arch)/$os/)

    if [ $code -ne 200 ];then 
        logger error "package not found" 
        exit 3 
    fi
}

function config(){
    if [ -f  /bin/python ];then
        echo 'ansible_python_interpreter: "/bin/python"' >>config.yaml
        echo
    elif [ -f /bin/python3 ];then
        echo 'ansible_python_interpreter: "/bin/python3"' >>config.yaml
        echo
    fi
    yum install ansible -y
    echo "javaurl: http://{{ lip }}:10000/package/java" >> config.yaml
    echo "url: http://{{ lip }}:10000/package/$(arch)/tar" >> config.yaml
    echo "os: $os" >> config.yaml
    echo "arch: $(arch)" >> config.yaml
    systemctl disable --now firewalld

    setenforce  0

    for  ip in $(egrep  -v '\[|ansible' hosts  | sort -u | sed '/^$/d');do
        if ip a| grep $ip &>/dev/null ;then
            echo "lip: $ip" >>config.yaml
            fl=true
        fi 
    done

    if [ ! $fl ] ;then
        ip=$(ip a | grep $( egrep  -v '\[|ansible' hosts  | sort -u | sed '/^$/d' | awk  -F '.' '{print $1"."$2}' | head -n1) | awk --re-interval '{match($0,/([0-9]{1,3}\.){3}[0-9]{1,3}/,a); print a[0]}')
        echo "lip: $ip" >>config.yaml
    fi

    namesrv=$(sed -n '/^\[rocketmq/,/\[/p' hosts | egrep [0-9] | head -n1)
    if [ ! -z $namesrv ];then
        echo "namesrv: $namesrv" >>config.yaml

    fi

}

function version_of_package() {
    
    current=$(pwd)
    soft=("admin" "config" "portal" "fdfs"  "tomcat" "zookeeper" "rocketmq-all" "rocketmq-dash" "maven" "activemq" "mysql" "xtrabackup" "redis" "jdk")
    dir=("package/java" "package/$(arch)/tar")
    
    for i in ${dir[@]};do
        cd $i
        ls -1 |grep -v  txt > txt
        
        for s in ${soft[@]};do
            
            cTar="$(grep $s txt)"
            
            
            if [ -z $cTar ];then
                continue
            fi
            
            dc=$(echo $cTar | awk -F '.' '{print $NF}')
            if [ "$dc" != "gz" -a  $dc != "zip" ];then
                s=$(echo $s| sed 's/-/_/g')
                echo "${s}: $cTar" >> $current/config.yaml

                continue
            elif [ "$dc" == "zip" ];then
                echo "${s}Tar: $cTar" >> $current/config.yaml
                continue
            fi
            s=$(echo $s| sed 's/-/_/g')
            echo "${s}Tar: $cTar"  >> $current/config.yaml
            c="$(tar tvf $cTar | head -n1 | awk '{print $NF}' | awk -F '/' '{print $1}' )"
            echo "${s}: $c" >> $current/config.yaml
        done
        rm -fr txt
        cd $current
    done
    

}


function start_task() {
    #echo -ne "[defaults]\nhost_key_checking = False\nremote_port = 22\n" >  /etc/ansible/ansible.cfg 
    cat > /etc/ansible/ansible.cfg<<EOF
[defaults]
host_key_checking = False
remote_port = 22
forks = 4
EOF
    cd $curr
    #ansible-playbook -i hosts -e "@config.yaml" test.yaml
    ansible-playbook -i hosts -e "@config.yaml" install.yaml
}



function end(){
    kill -9 $(ps aux | grep  we[b] |grep -v grep | awk '{print $2}')
}



function main(){
    export curr=$(dirname $0)
    cat config > config.yaml
    echo >> config.yaml
    check_os
    cd $curr
    start_web_service
    check_package
    create_repo
    config
    version_of_package
    start_task && \
    #config_mysql_backup
    end
    
}
main
