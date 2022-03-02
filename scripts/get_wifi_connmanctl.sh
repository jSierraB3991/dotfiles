#! /bin/bash
echo $(connmanctl services      \
    | grep "*"                  \
    | grep 'wifi'               \
    | head -1                   \
    | awk '{$1=""; print $0}'   \
    | awk 'BEGIN{FS="wifi"} {print $1}')
