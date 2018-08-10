====== Создание бэкапа ======

1. Добавил диск под бэкап в Vagrantfile
2. vagrant up
3. vagrant ssh
4. sudo -i
5. yum install xfsdump
6. script script1 
7. mkfs.ext4 /dev/sdf # sdf - как раз тот новый диск под бэкап из п. 1
8. mkdir /backup
9. mount /dev/sdf /backup
10. xfsdump -f /backup/root.xfsdump /
11. exit # end of script1

====== Запуск с LiveCD ======

1. Скачал minimal образ centos 7.0

Через интерфейс VirtualBox:
2. Выключил машину 
3. Подключил образ с CentOS к виртуальной машине в режиме Live CD
4. Запустил машину 
-> Troubleshooting 
-> Rescue a CentOS system 
-> Skip to shell

# 'script' в LiveCD нет, поэтому для этой части скрипта нет, описываю шаги в свободной форме.

5. vgchange -ay # подключились logical volumes (стали видны в lsblk)
6. lvreduce -L8G /dev/mapper/VolGroup00-LogVol00	# уменьшаем volume
7. mkfs.xfs -f /dev/mapper/VolGroup00-LogVol00		# форматируем volume
8. mkdir /oldroot	# сюда мы развернём дамп xfs
9. mount /dev/mapper/VolGroup00-LogVol00 /oldroot
10. mkdir /backup	# создаём папку и монтируем диск с дампом
11. mount /dev/sdf /backup
12. xfsrestore -f /backup/root.xfsdump /oldroot		# восстанавливаемся из бэкапа

В интерфейсе VirtualBox:
13. Выключил машину
14. Удалил образ с CentOS в настройках
15. Запустил машину в фоновом режиме

Дальше захожу в машину с помощью vagrant ssh и вижу:
[vagrant@otuslinux ~]$ df -kh
Filesystem                       Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-LogVol00  8.0G  767M  7.3G  10% /
devtmpfs                         487M     0  487M   0% /dev
tmpfs                            496M     0  496M   0% /dev/shm
tmpfs                            496M  6.7M  490M   2% /run
tmpfs                            496M     0  496M   0% /sys/fs/cgroup
/dev/sda2                       1014M   95M  920M  10% /boot
tmpfs                            100M     0  100M   0% /run/user/1000

Т.е. root-раздел уменьшился до 8G и система работоспособна. Logical groups и volumes выглядят так:
[root@otuslinux ~]# vgs
  VG         #PV #LV #SN Attr   VSize   VFree
  VolGroup00   1   2   0 wz--n- <38.97g <29.47g
[root@otuslinux ~]# lvs
  LV       VG         Attr       LSize Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  LogVol00 VolGroup00 -wi-ao---- 8.00g
  LogVol01 VolGroup00 -wi-ao---- 1.50g

