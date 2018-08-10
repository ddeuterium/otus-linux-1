Создал тестовую директорию с двумя файлами (с большим и маленьким):
1. script script3
2. mkdir /home/testDir
3. yes > /home/testDir/testFile1
^C
4. echo 'Hello World!' > /home/testDir/testFile2
5. ls -lh /home/testDir
total 408M
-rw-r--r--. 1 root root 408M Aug 10 21:17 testFile1
-rw-r--r--. 1 root root   13 Aug 10 21:18 testFile2


Создал снепшот:
6. lvcreate -L1G -s VolGroup00/lvol0

Удалил тестовую папку:
7. rm -rf /home/testDir

Отмонтировал /home:
8. umount /home
P.S. /home была занята из-за того, что в ней "находился" user vagrant. Пришлось остановить запись скрипта, выйти из sudo, сделать cd в корень, вернуться в sudo и начать запись нового скрипта - script script4.

Восстанавился со снепшота и примонтировал /home обратно:
9. lvconvert --merge VolGroup00/lvol2
10. mount /home

Проверил, что папка /home/testDir с содержимым восстановилась:
11. ls -lh /home/testDir/
total 408M
-rw-r--r--. 1 root root 408M Aug 10 21:17 testFile1
-rw-r--r--. 1 root root   13 Aug 10 21:18 testFile2

Проверил, что lvol2 пропал из списка volumes::
12. lvs
  LV       VG         Attr       LSize Pool Origin Data%  Meta%  Move Log Cpy%Sync Convert
  LogVol00 VolGroup00 -wi-ao---- 8.00g
  LogVol01 VolGroup00 -wi-ao---- 1.50g
  lvol0    VolGroup00 -wi-ao---- 4.00g
  lvol1    VolGroup00 rwi-aor--- 8.00g                                    100.00

13. exit # end of script4