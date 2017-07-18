1.配置回环地址
ifconfig lo:0 192.168.20.111 broadcast 192.168.20.111 netmask 255.255.255.0 up
route add -host 192.168.20.111 dev lo:0
2.设置LVS
ipvsadm -C
ipvsadm -At 192.168.20.111:80 -s rr
ipvsadm -at 192.168.20.111:80 -r 192.168.20.98 -g
ipvsadm -at 192.168.20.111:80 -r 192.168.20.102 -g
3.keepalived两种启动方式
（1）自己压缩包安装，参考该目录下的安装sh脚本，启动命令：/etc/init.d/keepalived start
（2）centos7 yum安装，配置成服务
    systemctl daemon-reload  重新加载
    systemctl enable keepalived.service  设置开机自动启动
    systemctl disable keepalived.service 取消开机自动启动
    systemctl start keepalived.service 启动
    systemctl stop keepalived.service停止
（3）查看启动状态
    systemctl status keepalived.service
    http://img.blog.csdn.net/20160709170738871?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center
4.nginx启动后外部无法访问
（1）检查linux防火墙
（2）查看防火墙配置
    Linux防火墙(Iptables)重启系统生效
    开启： chkconfig iptables on
    关闭： chkconfig iptables off
    
    Linux防火墙(Iptables) 即时生效，重启后失效
    开启： service iptables start
    关闭： service iptables stop
