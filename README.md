# deploy
## Support
rhel 7
euler 22.03 tls
## software
```bash
$ ls package/java/
apache-activemq-5.15.9-bin.tar.gz
apache-maven-3.2.5-bin.tar.gz
apache-tomcat-8.5.51.tar.gz
apollo-adminservice-2.0.0-github.zip
apollo-configservice-2.0.0-github.zip
apollo-portal-2.0.0-github.zip
rocketmq-all-4.6.0-bin-release.tar.gz
rocketmq-dashboard-1.0.1-SNAPSHOT.jar
zookeeper-3.4.14.tar.gz
```
```bash
$ ls -1 package/x86_64/tar/
jdk-8u151-linux-x86_64.tar.gz
mysql-5.7.41-linux-glibc2.12-x86_64.tar.gz
percona-xtrabackup-2.4.28-Linux-x86_64.glibc2.17-minimal.tar.gz
redis6_x86.tar.gz
```
```bash
# in package/x86_64/<euler> or <rhel>
$ repotrack sysstat iotop net-tools vim nc tcpdump clamav telnet unzip tar ncurses-compat-libs
#ruler 
$ python3-policycoreutils python3-libselinux
#rhel7
$ repotrack MySQL-python
#euler
$ repotrack python3-mysql
```
