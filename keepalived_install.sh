# -------------------------------------------------------- #
            ## Keepalived_intsall
# -------------------------------------------------------- #
# Keepalived installation
yum install -y gcc openssl-devel popt-devel
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