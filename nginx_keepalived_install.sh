#!/bin/bash
# author: kuangl
# mail: kuangl@orient-media.com
# description: The installation of Nginx files.
# -------------------------------------------------------- #
         ## Nginx_install
# -------------------------------------------------------- #
# Nginx installation
#CURRENT_PATH=$(pwd)
mkdir /root/software for i in $(rpm -q gcc gcc-c++ kernel-devel openssl-devel zlib-devel popt-devel popt-static libnl-devel wget make |grep 'not installed' | awk '{print $2}')
do
    yum -y install $i
done
[ -d /root/software ]
[ "$?" != 0 ] && 
cd /root/software
[ !  -e pcre-8.40.tar.gz ] && wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz
tar -zxvf pcre-8.40.tar.gz
cd pcre-8.40
./configure
make && make install
echo $? || [ $? != 0  ] || echo  " installation pcre  failed" || exit 1
cd /root/software
[ ! -e nginx-1.11.5.tar.gz ] && wget http://nginx.org/download/nginx-1.11.5.tar.gz
tar -zxvf nginx-1.11.5.tar.gz
cd nginx-1.11.5
./configure  --prefix=/usr/local/nginx --with-http_ssl_module --with-http_sub_module --with-http_stub_status_module  --with-http_gzip_static_module
make && make install
echo $? || [ $? != 0  ] || echo  " installation  nginx  failed" || exit 1
# -------------------------------------------------------- #
            ## Keepalived_intsall
# -------------------------------------------------------- #
# Keepalived installation
# error libnfnetlink headers missing
yum install -y libnfnetlink-devel
cd /root/software
[ ! -e keepalived-1.2.24.tar.gz ] &&  wget http://www.keepalived.org/software/keepalived-1.2.24.tar.gz
tar -zxvf keepalived-1.2.24.tar.gz
cd keepalived-1.2.24
./configure --prefix=/usr/local/keepalived
make && make install
cp /usr/local/keepalived/sbin/keepalived /usr/sbin/
cp /usr/local/keepalived/etc/rc.d/init.d/keepalived /etc/init.d/keepalived
cp /usr/local/keepalived/etc/sysconfig/keepalived /etc/sysconfig/
mkdir -p /etc/keepalived
cp /usr/local/keepalived/etc/keepalived/keepalived.conf /etc/keepalived/keepalived.conf
chmod +x /etc/init.d/keepalived
echo $? || [ $? != 0  ] || print " installation keepalived  failed" || exit 1
chkconfig --add keepalived
chkconfig --level 345 keepalived on