#!/bin/sh
meson setup build --cross-file arm-none-eabi.txt -Ddebug=true -Db_asneeded=false -Db_lundef=false -Db_pch=false



if [ "$1" = 'freertos' ]
then	
	cd ./build	
	echo "Set FreeRTOS to $2"
	meson configure -Dfreertos=$2
elif [ "$1" = 'debug_opt' ]
then
	cd ./build
	echo "Set debug optimization to "$2""
	meson configure -Ddebug_opt=$2
fi