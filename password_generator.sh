#!/bin/bash

LENGTH=12
MODE='strong'

usage() {
	echo "Usage: $0 [--simple | --strong | --pin] [length]"
	echo
	echo " --simple Generate alphanumeric password"
	echo " --strong Generate password with symbol (default)"
	echo " --pin    Generate numeric pin only"
	echo " length Opational, number of charecters (default: 12)"
	exit 1
}

if [[ "$1" == "--simple" || "$1" == "--strong" || "$1" == "--pin" ]];
then
	MODE="${1#--}"
	shift
fi

if [[ -n "$1" ]];
then
	if [[ "$1" =~ ^[0-9]+$ ]];
	then
		LENGTH=$1
	else
		usage
	fi
fi

SIMPLE_SET='A-Za-z0-9'
STRONG_SET='A-Za-z0-9!@#$%^&*()_+'
PIN_SET='0-9'

case "$MODE" in
	simple)
		pass=$(openssl rand -base64 48 | tr -dc "$SIMPLE_SET" | head -c "$LENGTH")
		;;
	strong)
		pass=$(openssl rand -base64 48 | tr -dc "$STRONG_SET" | head -c "$LENGTH")
		;;
	pin)	
		pass=$(openssl rand -base64 48 | tr -dc "$PIN_SET" | head -c "$LENGTH")
		;;
	*)
		usage
		;;
esac

echo "your $MODE password is: $pass"

