#!/bin/bash

#
# Build U-Boot image when `mkimage' tool is available.
#

MKIMAGE=$(type -path "${CROSS_COMPILE}mkimage")

if [ -z "${MKIMAGE}" ]; then
	MKIMAGE=$(type -path mkimage)
	if [ -z "${MKIMAGE}" ]; then
		# Doesn't exist
		echo '"mkimage" command not found - U-Boot images will not be built' >&2
		exit 1;
	fi
fi
echo "MKIMAGE=$MKIMAGE $@"

#/home/cdunson/sst/Scepter/sysroots/x86_64-pokysdk-linux/usr/bin/mkimage -D " -O dtb -o arch/arm/boot/dts/am3517-scepter.dtb -b 0 -i arch/arm/boot/dts/ -d arch/arm/boot/dts/.am3517-scepter.dtb.d.dtc.tmp arch/arm/boot/dts/.am3517-scepter.dtb.dts.tmp" -f /home/cdunson/sst/Scepter/scepter_fdt.its arch/arm/boot/uImage.itb
#/home/cdunson/sst/Scepter/sysroots/x86_64-pokysdk-linux/usr/bin/mkimage -f /home/cdunson/sst/Scepter/scepter_fdt.its arch/arm/boot/uImage.itb

#mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008000 -n "sst11" -d arch/arm/boot/zImage arch/arm/boot/uImage
cat arch/arm/boot/dts/am3517-scepter.dtb >> arch/arm/boot/zImage
#cat arch/arm/boot/dts/am3517-evm.dtb >> arch/arm/boot/zImage
#pwd

echo "KBUILD_DTBS="$KBUILD_DTBS
echo "MKIMAGE=$MKIMAGE"
# Call "mkimage" to create U-Boot image
${MKIMAGE} "$@"
