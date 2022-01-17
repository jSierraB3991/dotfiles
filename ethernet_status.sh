#!/bin/sh
 
echo "%{F#2495e7} %{F#ffffff}$(curl -s checkip.dyndns.org | grep -Eo '[0-9.]+')%{u-}"
