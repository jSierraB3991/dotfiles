#! /bin/bash

nmcli dev wifi list | grep '*' | awk '{$1="";$2=""; print $0}' | awk 'BEGIN{FS="Infra"}{print $1}'
