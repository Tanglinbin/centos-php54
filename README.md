通过运行lnmp一键安装到脚本包，自动化centos上安装php5.4.45.同时屏蔽了nginx的安装

配置文件路径为：/usr/local/php/etc/php-fpm.conf
容器内的php-fpm配置文件中的daemon为yes，导致没有前台进程，因此，容器启动后就停止了。
需要修改php-fpm.conf里daemonize = yes改为no

样本文件如下
echo '[global]'; \
echo 'daemonize = no'; \
echo; \
echo '[www]'; \
echo 'listen = 9000'; \

listen = /tmp/php-cgi.sock 替换成 listen = 9000

shell语句为：
sed -i '/\[global\]/a daemonize = no' /usr/local/php/etc/php-fpm.conf
sed -i 's/listen = \/tmp\/php-cgi\.sock/listen = 9000/' /usr/local/php/etc/php-fpm.conf
