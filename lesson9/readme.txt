Что я делал:

Создал 3 вагрант-файла: один для мастер-хоста под ansible и 2 для целевых хостов. Отличаются только ip-шниками и набором дисков. Файлы лежат в папке vagrants.
Поднял виртуалки (vagrant up, vagrant ssh).

Далее на "мастере":
1. Установил ansible:
yum install ansible
2. Создал папку для плейбуков и завёл плейбук:
cd /etc/ansible
mkdir playbooks
vim playbooks/nginx_playbook.yml
3. Создал каркасы для ролей "nginx" и "epel":
cd roles
ansible-galaxy init nginx
ansible-galaxy init epel
4. В роли "epel" правил только файл tasks/main.yml
5. В роли nginx правил:
5.1. tasks/main.yml
5.2. meta/main.yml (добавил "epel" в dependencies)
5.3. handlers/main.yml
5.4. vars/main.yml
5.5. завёл templates/nginx.conf (взял дефолтный конфиг и поменял 80-й порт в двух местах на макрос {{ nginx_port }}
6. Запустил ansible-playbook /etc/ansible/playbooks/nginx_playbook.yml

На host1 и host2 ничего не делал - только проверил по итогу, что nginx установился, что в конфиге прописан нужный порт и что после ребута nginx поднимается автоматически.

