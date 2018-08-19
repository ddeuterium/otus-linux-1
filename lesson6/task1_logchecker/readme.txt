Что я делал:

1. Написал скрипт проверки лога - /usr/bin/mychecker.sh
2. Создал файлы mychecker.timer и mychecker.service в /lib/systemd/system
3. Создал конфиг-файл /etc/sysconfig/mychecker
4. Запустил сервис:
systemctl daemon-reload
systemctl start mychecker.timer

Вот результат работы сервиса:
[root@otuslinux vagrant]# tail -n3 /var/log/mychecker/mychecker.log
DateTime: Sun Aug 19 00:25:30 MSK 2018 File: /var/log/messages, keyword: mychecker, occurences: 1743
DateTime: Sun Aug 19 00:26:00 MSK 2018 File: /var/log/messages, keyword: mychecker, occurences: 1745
DateTime: Sun Aug 19 00:26:30 MSK 2018 File: /var/log/messages, keyword: mychecker, occurences: 1747

(он считает количество слов "mychecker" в /var/log/messages. Это количество постоянно растёт, т.к. в /var/log/messages появляется 2 строчки на каждый запуск сервиса (и эти строчки содержат description сервиса).
Aug 18 21:26:30 otuslinux systemd: Starting mychecker: scan log for keyword...
Aug 18 21:26:30 otuslinux systemd: Started mychecker: scan log for keyword.