#!/bin/sh

echo "=================================="
echo " Setting up Splunk Forwarder"
echo "=================================="

SPLUNKDEPLOY="$1"
SPLUNKGUID="$2"
SPLUNKPASS="$3"

mkdir -p /opt/splunkforwarder
cd /opt/splunkforwarder

SplunkRPM="splunkforwarder.rpm"
wget URL/${SplunkRPM} --no-check-certificate
rpm -i ${SplunkRPM}
rm -f ${SplunkRPM}

cat << EOF >> "/opt/splunkforwarder/etc/system/local/user-seed.conf"
[user_info]
USERNAME = admin
PASSWORD = ${SPLUNKPASS}
EOF

/opt/splunkforwarder/bin/splunk set deploy-poll ${SPLUNKDEPLOY} --accept-license --answer-yes

if [[ ! -z "$SPLUNKGUID" ]]; then
        rm -f /opt/splunkforwarder/etc/instance.cfg

cat << EOF >> "/opt/splunkforwarder/etc/instance.cfg"
[general]
guid = ${SPLUNKGUID}
EOF
fi

/opt/splunkforwarder/bin/splunk start --accept-license
/opt/splunkforwarder/bin/splunk enable boot-start

cd ~
systemctl enable splunk

echo "========================="
echo " DONE with Splunk Setup" 
echo "========================="
