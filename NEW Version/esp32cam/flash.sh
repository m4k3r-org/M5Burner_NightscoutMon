#!/bin/bash

machine=""
port=""

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=MacOS;;
    CYGWIN*)    machine=Win;;
    MINGW*)     machine=Win;;
    *)          machine=UNKNOWN
esac

# echo ${machine}

if [ "${machine}" == "Linux" ]; then
    echo "linux"
    port="ttyUSB0"
fi

if [ "${machine}" == "MacOS" ]; then
    echo "MacOS"
    port="tty.SLAB_USBtoUART"
fi

# echo ${port}

esptool.py --chip esp32 --port /dev/${port} --baud 921600 --before default_reset --after no_reset write_flash -z \
--flash_mode dio --flash_freq 80m --flash_size detect \
0x1000 bootloader_0x1000.bin \
0x10000 esp32cam_0x10000.bin \
0x8000 partitions_singleapp_0x8000.bin \
