mdadm --create /dev/md0 --level=10 --raid-devices=4 /dev/sdb /dev/sdc /dev/sdd /dev/sde
mdadm --create /dev/md1 --level=1 --raid-devices=2 /dev/sdf /dev/sdg
mdadm --create /dev/md2 --level=0 --raid-devices=2 /dev/sdh /dev/sdi
