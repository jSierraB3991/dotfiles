#! /bin/bash

nmcli dev wifi list | grep '*' | awk '{print $3 " " $4}'
