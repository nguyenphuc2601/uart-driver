#!/bin/sh

clear
echo "      -------------------------------------------------------------------
                                OpenOCD v0.11.0                 
      ------------------------------------------------------------------- "

echo "Memory Programming ..."

openocd   \
  -f interface/stlink.cfg  \
  -c "
    set WORKAREASIZE 0x8000
    set ENABLE_LOW_POWER 1
    set STOP_WATCHDOG 1
    set CLOCK_FREQ 8000
    reset_config none
    set CONNECT_UNDER_RESET 0
    set CORE_RESET 0
    set AP_NUM 0
    set GDB_PORT 3333
    source [find target/$2]

    gdb_report_data_abort enable
    gdb_port 3333
    tcl_port 6666
    telnet_port 4444

    init;
    reset init;
    halt;
    # program $1;
    program $1 verify;
    reset;
    exit
  "

