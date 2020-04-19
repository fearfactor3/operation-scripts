#!/bin/bash

# If you decide to download from the internet uncomment line 4 and 5, else uncomment 7.
# wget URL HERE
yum localinstall -y FILEHERE

# yum install -y java-1.8.0-openjdk-devel

# Creates the setJavaHome.sh
cat <<EOF > /etc/profile.d/setJavaHome.sh
JAVA_HOME=/usr/lib/jvm/java-1.8.0-amazon-correcto
PATH=$JAVA_HOME/bin:$PATH
export JAVA_HOME PATH
EOF

yum remove jre -y
rpm -qa | grep java > $HOME/somefile.txt
sed -i 'CHANGEME!' $HOME/somefile.txt
rpm -e $(cat $HOME/somefile.txt)
rm -rf $HOME/somefile.txt

find /usr/lib/jvm -maxdepth 1 > $HOME/somefile2.txt
sed -i 'CHANGEME!' $HOME/somefile2.txt
sed -i 'CHANGEME!' $HOME/somefile2.txt
rpm -e $(cat $HOME/somefile2.txt)
rm -rf $HOME/somefile2.txt