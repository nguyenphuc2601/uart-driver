#!/bin/sh

meson setup --reconfigure --wipe build --cross-file arm-none-eabi.txt -Ddebug=true -Db_asneeded=false -Db_lundef=false -Db_pch=false