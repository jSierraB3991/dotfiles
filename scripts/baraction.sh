#!/bin/bash

hostname="${HOSTNAME:-${hostname:-$(hostname)}}"

##############################
#	    DISK
##############################

hddicon() {
    echo ""
}

hdd() {
    free="$(df -h /home | grep /dev | awk '{print $3}' | sed 's/G/Gb/')"
    perc="$(df -h /home | grep /dev/ | awk '{print $5}')"
    echo "$perc  ($free)"
}

##############################
#	    RAM
##############################
memicon() {
    echo ""
}

mem() {
    used="$(free | grep Mem: | awk '{print $3}')"
    total="$(free | grep Mem: | awk '{print $2}')"
    human="$(free -h | grep Mem: | awk '{print $3}' | sed s/i//g)"
    ram="$(( 200 * $used/$total - 100 * $used/$total ))% ($human) "
    echo "$ram"
}
##############################
#	    CPU
##############################
cpuicon() {
    echo ""
}

cpu() {
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    echo "$cpu%"
}

##############################
#	    VOLUME
##############################
volicon() {
    VOLONOFF="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $6}')"

    VOLON="蓼"
    VOLOFF="遼"

    if [ "$VOLONOFF" = "on" ]; then
        echo "$VOLON"
    else
        echo "$VOLOFF"
    fi
}

vol() {
    VOL="$(amixer -D pulse get Master | grep Left: | sed 's/[][]//g' | awk '{print $5}')"

    echo "$VOL"
}
##############################
#	    Packages
##############################
pkgicon() {
    echo ""
}

pkgs() {
	pkgs="$(dpkg -l | grep -c ^i)"
	echo "$pkgs"
}
##############################
#	    UPGRADES
##############################
upgradeicon() {
    	echo ""
}

upgrades(){
	upgrades="$(aptitude search '~U' | wc -l)"
	echo "$upgrades"
}
##############################
#	    NETWORK
##############################
networkicon() {
wire="$(ip a | grep "eth0\|enp" | grep inet | wc -l)"
wifi="$(ip a | grep wlan | grep inet | wc -l)"

if [ $wire = 1 ]; then
    echo ""
elif [ $wifi = 1 ]; then
    echo ""
else
    echo "睊"
fi

}

ipaddress() {
    address="$(curl -s checkip.dyndns.org | grep -Eo '[0-9.]+')"
    echo "$address"
    #echo "181.150.229.192"
}

vpnconnection() {
    state="$(ip a | grep vpn | grep inet | wc -l)"
    vpn_ip="$(ip a | grep vpn | grep inet | grep -Eo '[0-9.]+' | head -1)"

    if [ $state = 1 ]; then
	echo "ﱾ $vpn_ip"
    else
	echo " No VPN"
    fi
}

## BATTERY
bat() {
    battery="BAT1"

    batstat="$(cat /sys/class/power_supply/$battery/status)"
    battery="$(cat /sys/class/power_supply/$battery/capacity)"
    if [ $batstat = 'Unknown' ]; then
        batstat=""
    elif [[ $battery -ge 5 ]] && [[ $battery -le 19 ]]; then
        batstat=""
    elif [[ $battery -ge 20 ]] && [[ $battery -le 39 ]]; then
        batstat=""
    elif [[ $battery -ge 40 ]] && [[ $battery -le 59 ]]; then
        batstat=""
    elif [[ $battery -ge 60 ]] && [[ $battery -le 79 ]]; then
        batstat=""
    elif [[ $battery -ge 80 ]] && [[ $battery -le 95 ]]; then
        batstat=""
    elif [[ $battery -ge 96 ]] && [[ $battery -le 100 ]]; then
        batstat=""
fi

echo "$batstat  $battery %"
}

clockicon() {
    CLOCK=$(date '+%I')

    case "$CLOCK" in
    "00") icon="" ;;
    "01") icon="" ;;
    "02") icon="" ;;
    "03") icon="" ;;
    "04") icon="" ;;
    "05") icon="" ;;
    "06") icon="" ;;
    "07") icon="" ;;
    "08") icon="" ;;
    "09") icon="" ;;
    "10") icon="" ;;
    "11") icon="" ;;
    "12") icon="" ;;
    esac

    echo "$(date "+$icon")"
}

dateinfo() {
    echo "$(date "+%Y/%m/%d (%a)")"
}

clockinfo() {
    echo $(date "+%H:%M:%S")
}

temp_info() {
    icon=""
    label="0"
    temp=$(~/.config/bin/temperature)
    temp_number=$( printf "%.0f" $temp )
    if [ $temp_number -ge 50 ] && [ $temp_number -lt 65 ]; then
        icon=""
        label="1"
    elif [ $temp_number -ge 65 ] && [ $temp_number -lt 75 ]; then
        icon=""
        label="2"
    elif [ $temp_number -ge 75 ]; then
        icon=""
        label="3"
    fi
    echo "+@fg=$label; $icon $temp"
}


SLEEP_SEC=2
#loops forever outputting a line every SLEEP_SEC secs
while :; do
#    echo "+@fg=1; $(cpuicon) +@fg=0; $(cpu)\
#	+@fg=1; $(memicon) +@fg=0; $(mem); \ 
#	$(hdd); \
#	$(vpn); \
#	$(network); \
#	$(vol)"
    echo "+@fg=1; $(cpuicon) +@fg=0; $(cpu) +@fg=1; $(memicon) +@fg=0; $(mem) +@fg=3; $(hddicon) +@fg=0; $(hdd) +@fg=4; $(networkicon) +@fg=0; $(ipaddress) +@fg=4; $(vpnconnection) $(temp_info) $(bat) +@fg=4; $(clockicon) +@fg=0; $(clockinfo)"
    #sleep $SLEEP_SEC
done

