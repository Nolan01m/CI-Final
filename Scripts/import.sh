#/bin/bash
for i in ./Splunk_Config
do
cp /opt/splunk/etc/system/local/$i
done
