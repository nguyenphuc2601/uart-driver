#!/bin/sh
cd ./build

if [ "$1" = "clean" ]
then
	meson compile --clean
	echo "Finished cleaning"
	exit
fi


clear

meson compile $1

if [ "$?" -eq 1 ]
then
	echo "Error 1"
	echo 'make: *** Waiting for unfinished jobs....
	"make -j8 all" terminated with exit code 2. Build might be incomplete.'
	exit
fi

echo "make -j8 all 
arm-none-eabi-size   helloworld_arm.elf "
cat *.size
echo "Finished building: default.size.stdout"



