#! /bin/bash
curl -s checkip.dyndns.org | grep -Eo '[0-9.]+'
