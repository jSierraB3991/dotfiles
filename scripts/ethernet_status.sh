
    file="/home/juan-sierra/.config/bin/data.txt"
    curl -s checkip.dyndns.org > $file 

    if [ "$(cat $file | wc -l)" = "1" ]; then
        echo "$(cat $file | grep -Eo '[0-9.]+')"
    else
        echo "BAD GATEWAY"
    fi
