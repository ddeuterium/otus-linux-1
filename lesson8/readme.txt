Что я делал:

Поднял вагрантом две виртуалки (для второй виртуалки в Vagrant-файле поменял ip). В одной собрал rpm для php, поднял nginx и создал репозиторий, во второй подключил этот репозиторий и установил из него php.


==================

На первой виртуалке:

1. Собрал rpm php
1.1. yumdownloader php
1.2. rpm -i php-5.4.16-45.el7.src.rpm
1.3. cd rpmbuild/SPECS/
1.4. yum-builddep php.spec
1.5. Убрал из в php.spec "--without-fileinfo"
1.6. Собрал rpm:
     rpmbuild -ba php.spec

2. Установил nginx и положил в /usr/share/nginx/html все rpm из ~/rpmbuild/RPMS
3. Зашёл в /usr/share/nginx/html и запустил createrepo

==================

На второй виртуалке:

1. Создал файл /etc/yum.repos.d/azotus.repo с таким содержимым:
[azotus]
name = AzOtus-Linux
baseurl=http://192.168.11.101
enabled=0

2. Команда 
yum --disablerepo=* --enablerepo=azotus list
показала, помимо прочих, пакет из репозитория azotus:

php.x86_64                             5.4.16-45.el7.centos               azotus

3. Установил php:

yum --enablerepo=azotus install php --nogpgcheck

В ходе установки был такой вывод - тут видно, что php установился именно из azotus.

==========================================================================================
 Package             Arch           Version                         Repository       Size
==========================================================================================
Installing:
 php                 x86_64         5.4.16-45.el7.centos            azotus          1.5 M


А здесь видно, что fileinfo действительно включен, как мы и хотели:
[root@otuslinux ~]# php -i | grep fileinfo
/etc/php.d/fileinfo.ini,
fileinfo
fileinfo support => enabled