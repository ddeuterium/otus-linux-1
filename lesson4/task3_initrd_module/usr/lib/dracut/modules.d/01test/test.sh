#!/bin/bash
exec 0<>/dev/console 1<>/dev/console 2<>/dev/console
cat <<'msgend'

======================
< I'm dracut module !! >
----------------------
    \
     \
          .--.
        | 0_0 |
        | :_/ |
       //    \ \
      (|      | )
     /'\_    _/`\
     \___)=(____/
msgend
sleep 10
echo " continuing...."
