#/bin/bash

read -p 'DNS Username: ' uservar
read -p 'DNS Password: ' passvar

#Install Pre-reqs for ddclient
sudo amazon-linux-extras install epel nano -y 
#Installing ddclient
sudo yum install ddclient -y
#Configuring ddclient on Splunk
echo "
ssl=yes
protocol=googledomains
use=web, web=checkip.dyndns.org/
login=$uservar
password='$passvar'
splunk.nhlabs.org
" >> /etc/ddclient.conf
#automatic startup on boot
cp sample-etc_systemd.service /etc/systemd/system/ddclient.service
systemctl enable ddclient.service
systemctl start ddclient.service

#configuring daemon mode
cp sample-etc_rc.d_init.d_ddclient /etc/rc.d/init.d/ddclient
/sbin/chkconfig --add ddclient
/etc/rc.d/init.d/ddclient start

#For Debugging: ddclient -daemon=0 -debug -verbose -noquiet
