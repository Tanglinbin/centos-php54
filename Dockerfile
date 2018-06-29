FROM centos:7.5.1804

COPY ./answer.txt /tmp

RUN yum update \
  && yum install -y wget \
  && wget -c http://soft.vpser.net/lnmp/lnmp1.4.tar.gz -P /tmp \
  && tar -zxf /tmp/lnmp1.4.tar.gz -C /tmp \
  && sed -i 's/Install_Nginx/\#Install_Nginx/g' /tmp/lnmp1.4/install.sh \
  && cd /tmp/lnmp1.4/ \
  && groupadd www \
  && useradd -s /sbin/nologin -g www www \
  && ./install.sh < /tmp/answer.txt \
  && sed -i '/\[global\]/a daemonize = no' /usr/local/php/etc/php-fpm.conf \
  && sed -i 's/listen = \/tmp\/php-cgi\.sock/listen = 9000/' /usr/local/php/etc/php-fpm.conf \
  && yum clean all \
  && rm -rf /var/cache/yum \
  && rm -rf /tmp/*

# CMD ["/tmp/lnmp1.4/install.sh < /tmp/answer.txt"]
# Enter your choice (1, 2, 3, 4, 5, 6, 7 or 0): 选择数据库输入0
# Enter your choice (1, 2, 3, 4, 5, 6 or 7): 选择php5.4输入3n
# Enter your choice (1, 2 or 3): 选择不安装内存分配，输入1
# Press any key to install...or Press Ctrl+c to cancel 发送任意键数值信号

EXPOSE 9000
CMD ["php-fpm"]
