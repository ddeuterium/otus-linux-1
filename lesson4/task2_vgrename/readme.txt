Что делал:

1. vgrename VolGroup00 VolGroupNew
2. Отредактировал /etc/fstab - заменил VolGroup00 на VolGroupNew
3. Отредактировал /boot/grub2/grub.cfg - заменил VolGroup00 на VolGroupNew 
4. Пересобрал initramfs:
mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)
5. reboot
6. Система успешно загрузилась (правда почему-то только со второй попытки. Долго висела. Пришлось закрыть машину через VirtualBox и ещё раз запустить. Запустилась.
Volume group действительно переименовалась:

[root@otuslinux ~]# vgs
  VG          #PV #LV #SN Attr   VSize   VFree
  VolGroupOld   1   2   0 wz--n- <38.97g    0

[root@otuslinux ~]# df -kh
Filesystem                        Size  Used Avail Use% Mounted on
/dev/mapper/VolGroupOld-LogVol00   38G  945M   37G   3% /