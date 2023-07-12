#!/bin/bash
nohup /opt/rocketmq/bin/mqnamesrv  &>>/opt/rocketmq/namesrv.log &
nohup /opt/rocketmq/bin/mqbroker -c "/opt/rocketmq/conf/dledger-hc/n0.properties" &>>/opt/rocketmq/n0.log &
nohup /opt/rocketmq/bin/mqbroker -c "/opt/rocketmq/conf/dledger-hc/n1.properties" &>>/opt/rocketmq/n1.log &
nohup /opt/rocketmq/bin/mqbroker -c "/opt/rocketmq/conf/dledger-hc/n2.properties" &>>/opt/rocketmq/n2.log &
