#!/bin/bash
set -x
export PYTHONPATH=/usr/local/lib/python2.7
export SPLUNK_HOME=/opt/splunkforwarder
wget -O /tmp/apps.zip $APPSURL
unzip /tmp/apps.zip -d /opt/splunkforwarder/etc/apps/
sed -i "s/TARGETHOST/$TARGETHOST/g" /opt/splunkforwarder/etc/system/local/outputs.conf
echo `hostname` > /opt/splunkforwarder/etc/apps/SA-Eventgen/samples/hostname.sample
/opt/splunkforwarder/bin/splunk start --accept-license
tail -f /opt/splunkforwarder/var/log/splunk/splunkd.log