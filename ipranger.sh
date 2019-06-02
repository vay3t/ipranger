#!/bin/bash

which curl &> /dev/null
if [ $? -eq 0 ]; then
	if [ $# -eq 1 ]; then
		for asn in $(curl https://ipinfo.io/countries/$1 -s | grep "a href" | grep -iE "as[0-9]" | cut -d ">" -f3 | cut -d "<" -f1); do
			echo "# $asn"
			for iprange in $(curl https://ipinfo.io/$asn -s | grep $asn | grep -ioE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,2}\b"); do
				echo $iprange
			done
			echo ""
		done
	else
		echo "[*] Usage: bash $0 <country code>"
		echo "Example: bash $0 us"
	fi
else
	echo "[-] please install curl"
fi

