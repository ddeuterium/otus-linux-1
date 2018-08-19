Что я делал:

1. Установил apache:

yum install httpd.x86_64

2. Завёл конфиги /etc/httpd-first и /etc/httpd-second для двух сервисов:

cp -r /etc/httpd /etc/httpd-first
cp -r /etc/httpd /etc/httpd-second

3. Отредактировал конфиги:

В httpd.conf для httpd-first поменял 2 строчки:

ServerRoot "/etc/httpd-first"
PidFile "/run/httpd/httpd-first.pid"

В httpd.conf для httpd-second поменял 3 строчки:

ServerRoot "/etc/httpd-second"
PidFile "/run/httpd/httpd-second.pid"
Listen 8080

4. Переименовал unit-файл:
cd /lib/systemd/system
mv httpd.service httpd@.service

5. Отредактировал unit-файл:

Добавил опцию " -f /etc/httpd-%I/conf/httpd.conf" в ExecStart

6. Запустил сервисы:
systemctl daemon-reload
systemctl start httpd@first.service
systemctl start httpd@second.service

Вот результат:

[root@otuslinux vagrant]# ps xawf -eo pid,user,cgroup,args | grep http[d]
 8090 root     6:devices:/system.slice,1:n /usr/sbin/httpd -f /etc/httpd-first/conf/httpd.conf -DFOREGROUND
 8091 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-first/conf/httpd.conf -DFOREGROUND
 8092 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-first/conf/httpd.conf -DFOREGROUND
 8093 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-first/conf/httpd.conf -DFOREGROUND
 8094 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-first/conf/httpd.conf -DFOREGROUND
 8095 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-first/conf/httpd.conf -DFOREGROUND
 8102 root     6:devices:/system.slice,1:n /usr/sbin/httpd -f /etc/httpd-second/conf/httpd.conf -DFOREGROUND
 8103 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-second/conf/httpd.conf -DFOREGROUND
 8104 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-second/conf/httpd.conf -DFOREGROUND
 8105 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-second/conf/httpd.conf -DFOREGROUND
 8106 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-second/conf/httpd.conf -DFOREGROUND
 8107 apache   6:devices:/system.slice,1:n  \_ /usr/sbin/httpd -f /etc/httpd-second/conf/httpd.conf -DFOREGROUND