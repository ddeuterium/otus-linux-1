Что я делал:

1. Создал папку 01test в /usr/lib/dracut/modules.d
2. В папке создал 2 файла - module-setup.sh и test.sh
3. chmod +x на файлы
4. Скопировал в файлы код из pdf-ки к уроку
5. dracut --force + reboot -> не взлетело
6. Обратил внимание на отличие module-setup.sh от аналогичного файла в 00bash - 2 дополнительные строчки в начале файла:

# -*- mode: shell-script; indent-tabs-mode: nil; sh-basic-offset: 4; -*-
# ex: ts=8 sw=4 sts=4 et filetype=sh

Добавил эти строчки в свой файл, опять dracut --force + reboot - так взлетело, на последнем этапе загрузки появился и завис на 10 секунд пингвин.