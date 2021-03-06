#!/bin/bash
#

mkdir -p ${upperdir}/usr/bin/
arm-linux-gnueabihf-gcc ${lowerdir}/sunxi-temp/sunxi_tp_temp.c -o ${upperdir}/usr/bin/sunxi_tp_temp

# convert and add fex files
mkdir -p ${upperdir}/boot/bin

for i in $(ls -w1 $SRC/config/fex/*.fex | xargs -n1 basename); do
	fex2bin $SRC/config/fex/${i%*.fex}.fex ${upperdir}/boot/bin/${i%*.fex}.bin
done

mkdir -p ${upperdir}/usr/lib/nand-sata-install
mkdir -p ${upperdir}/usr/sbin

install -m 755 ${sectiondir}scripts/nand-sata-install/nand-sata-install ${upperdir}/usr/sbin
install -m 644 ${sectiondir}scripts/nand-sata-install/exclude.txt ${upperdir}/usr/lib/nand-sata-install
cp -R ${sectiondir}scripts/nand-sata-install/a* ${upperdir}/usr/lib/nand-sata-install
