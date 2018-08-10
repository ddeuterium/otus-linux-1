Добавил новый диск в volume group (без отдельного диска зеркало не создавалось):
1. script script2
2. pvcreate /dev/sdf
3. vgextend VolGroup00 /dev/sdf

Создал и отформатировал logical volumes:
4. lvcreate -L4G VolGroup00 # 4 гигабайта под home
5. lvcreate -L8G -m1 VolGroup00 # 8 гигабайт под var + mirror
6. mkfs.ext4 /dev/mapper/VolGroup00-lvol0
7. mkfs.ext4 /dev/mapper/VolGroup00-lvol1

Создал новые директории и примонтировал к ним volumes:
8. mkdir /home_new
9. mkdir /var_new
10. mount /dev/mapper/VolGroup00-lvol0 /home_new
11. mount /dev/mapper/VolGroup00-lvol1 /var_new

Скопировал содержимое старых директорий в новые:
12. rsync -aX /home/. /home_new/.
13. rsync -aX /var/. /var_new/.
14. exit # end of script2

Добавил в fstab 2 строчки (взял их из /etc/mtab и заменил home_new/var_new на home/var):
/dev/mapper/VolGroup00-lvol0 /home ext4 rw,seclabel,relatime,data=ordered 0 0
/dev/mapper/VolGroup00-lvol1 /var ext4 rw,seclabel,relatime,data=ordered 0 0

Удалил всё из старой /home:
15. rm -rf /home/*

16. Для очистки старой /var пришлось опять запуститься с LiveCD (можно было и не очищать /home и var, новые volume примонтировались бы "поверх" них благодаря fstab, но эти фантомные папки продолжали бы существовать и могли бы вновь всплыть при проблемах с монтированием volume, что не очень красиво).
P.S. Потом выяснил, что можно было обойтись без LiveCD - перезапустить систему, подмонтировать корень к временной папке с помощью --bind и почистить home и var во временной папке.
17. Удалил также ненужные больше пустые /home_new и /var_new

Перезапустил систему.
В выводе df появились /var и /home:
[vagrant@otuslinux ~]$ df -hT
Filesystem                      Type      Size  Used Avail Use% Mounted on
/dev/mapper/VolGroup00-lvol0    ext4      3.9G   17M  3.6G   1% /home
/dev/mapper/VolGroup00-lvol1    ext4      7.8G  161M  7.2G   3% /var
P.S. Не понял, почему в этом выводе Size != Used + Avail
