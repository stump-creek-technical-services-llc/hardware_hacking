# Workflow: ROMs

1. If possible, factory-reset the firmware to reduce potential PII leaks.
2. Document the chip as it is on the board. 
3. Identify the chip.
4. Acquire datasheet, record the link.
5. Remove from circuit, usually with a hot air reflow tool.
6. Load the chip into the programmer
7. Use `flashrom` to scan for the chip.
Choose the right chip from the list of detected chips.
```shell
cd firmware-images
make scan
```
8. Dump the chip
```shell
make dump FLAVOR=reset CHIP=$CHIP_DESIGNATOR
```
9. Put the chip back in the circuit.

I have not had good luck using an [IC test clip](https://commons.wikimedia.org/wiki/File:IC-TEST-CLIP.jpg)
to read the ROM in-circuit.
It seems that either there is a poor connection,
or applying power to the ROM applies power to too many other things.
The ROMs that I dump go into an archive,
so it's worthwhile to make sure they're correct.
It's usually best to remove them from the circuit and read them properly.

If JTAG is available and can access the ROM,
that's very convenient.

The [Amazon CloudCam's large flash chip](../../devices/Amazon_CloudCam_PB40JL/photos/chip_SKhynix_H26M31001HPR_2.jpg)
was adhered to the PCB with some kind of very tough resin,
I'm going to guess it was some heat-set epoxy,
and an anti-tampering measure.

I have found it very easy to make mistakes with the orientation of small chips like SOP/SOIC-8.
* All too often, the index mark on the chip is very subtle.
* Sometimes there's a paint mark on the chip,
which I think usually identifies that it's been programmed.
Sometimes that mark is on the opposite end from the index,
and it's easy to get confused.
* The PCB silkscreen showing the index is often underneath the part,
meaning that when you look at the assembled board,
you can't see that it's in wrong.
* Many times, I've set the chip down correctly,
then for some reason the chip moved and I had to reposition it,
and got it wrong.

The VCC and GND pins are on opposite corners of SPI ROMs,
which means that if you rotated it by 180 degrees,
it's powered backwards and gets hot.
Burn-your-skin hot.
At that point, I usually assume that the chip is ruined,
throw it in the trash, take a replacement out of stock, reflash it,
and try not to make the same mistake when installing the second chip.
It's happened. 😭
