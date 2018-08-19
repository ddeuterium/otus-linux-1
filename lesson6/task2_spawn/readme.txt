Что я делал:

1. Установил epel, spawn-fcgi и php:
yum install epel-release
yum install spawn-fcgi.x86_64
yum install php

2. Создал unit-файл /lib/systemd/system/spawn-fcgi.service

3. Раскомментировал 2 строчки в /etc/sysconfig/spawn-fcgi

4. Запустил сервис:
systemctl daemon-reload
systemctl start spawn-fcgi.service

Вот результат:

[root@otuslinux vagrant]# systemctl status spawn-fcgi
● spawn-fcgi.service - Spawn FastCGI scripts to be used by web servers
   Loaded: loaded (/usr/lib/systemd/system/spawn-fcgi.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2018-08-20 02:16:23 MSK; 6s ago
  Process: 11924 ExecStart=/usr/bin/spawn-fcgi $OPTIONS (code=exited, status=0/SUCCESS)
 Main PID: 11925 (php-cgi)
   CGroup: /system.slice/spawn-fcgi.service
           ├─11925 /usr/bin/php-cgi
           ├─11926 /usr/bin/php-cgi
           ├─11927 /usr/bin/php-cgi
           ├─11928 /usr/bin/php-cgi
           └─11929 /usr/bin/php-cgi

Aug 20 02:16:23 otuslinux systemd[1]: Starting Spawn FastCGI scripts to be used by web servers...
Aug 20 02:16:23 otuslinux spawn-fcgi[11924]: spawn-fcgi: child spawned successfully: PID: 11925
Aug 20 02:16:23 otuslinux systemd[1]: Started Spawn FastCGI scripts to be used by web servers.


[root@otuslinux vagrant]# ps xawf -eo pid,user,cgroup,args | grep ph[p]
11925 apache   6:devices:/system.slice,1:n /usr/bin/php-cgi
11926 apache   6:devices:/system.slice,1:n  \_ /usr/bin/php-cgi
11927 apache   6:devices:/system.slice,1:n  \_ /usr/bin/php-cgi
11928 apache   6:devices:/system.slice,1:n  \_ /usr/bin/php-cgi
11929 apache   6:devices:/system.slice,1:n  \_ /usr/bin/php-cgi