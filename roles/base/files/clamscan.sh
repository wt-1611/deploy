#!/bin/bash
/usr/bin/clamscan  -r /home > /var/log/clamav/clamscan_home_$(date +%Y%m%d%H%M%S).log 2>&1 
/usr/bin/clamscan  -r /tmp  > /var/log/clamav/clamscan_tmp_$(date +%Y%m%d%H%M%S).log 2>&1 
/usr/bin/clamscan  -r /usr/local/tomcat > /var/log/clamav/clamscan_tomcat_$(date +%Y%m%d%H%M%S).log 2>&1