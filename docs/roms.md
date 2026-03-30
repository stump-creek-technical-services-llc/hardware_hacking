# ROMs

This document is about ROM chips.

There are several very common ROM chip types, and several less common.

* SPI NOR Flash
* SPI NAND Flash
* eMMC

## SPI NOR Flash

This type of flash typically shares the same command set,
with just couple standard packages and pinouts.

Part numbers are frequently in the `25` series:
* Winbond W25Q128FVSG

Voltage range is typically 2.6V to 3.6V.
Chip frequencies are often >100 MHz,
although my programmer isn't nearly that fast.

### SOIC-8 and SOP-8 Package

In my experience,
the most common form of the SPI NOR flash has been the SOIC-8 and SOP-8 packages.

[The packages are very similar](https://en.wikipedia.org/wiki/Small_outline_integrated_circuit#General_package_characteristics), varying a little bit by width.


| Pin | SPI-Mode Name | SPI Mode Function         | Dual-SPI Mode | Quad-SPI Mode | Note                               |
|-----|---------------|---------------------------|---------------|---------------|------------------------------------|
| 1   | /CS           | Chip select, active low   | /CS           | /CS           |                                    |
| 2   | DO            | MISO                      | IO1           | IO1           | 10 mA max, recommend 4.7K resistor |
| 3   | /WP           | Write protect, active low | /WP           | IO2           |                                    |
| 4   | GND           | Ground                    | GND           | GND           |                                    |
| 5   | DI            | MOSI                      | IO0           | IO0           |                                    |
| 6   | CLK           | SPI clock                 | CLK           | CLK           |                                    |
| 7   | /HOLD         | Hold, active low          | /HOLD         | IO3           | Often also /RESET                  |
| 8   | VCC           | Positive supply           | VCC           | VCC           | 2.6V to 3.6V                       |

### Programming

#### Hardware

##### pico-serprog

pico-serprog is a programmer made from a Pico, which I have on hand,
and open-source firmware.

#### Software

##### flashrom

I prefer flashrom because it works on Mac and Linux,
and works nicely with pico-serprog.

### Wiring

#### For DIP-8 (SOIC/SOP-8 on a Carrier)

For eight-pin chips, which are usually surface-mount parts,
I first put them in/on a carrier, which gives them DIP-8 interfaces.
This is how I have my pico-serprog wired to read them:

![pico-serprog_dip-8_bb.svg](pico-serprog/pico-serprog_dip-8_bb.svg)

[pico-serprog_dip-8.fz](pico-serprog/pico-serprog_dip-8.fz)

Note that `/HOLD (/RESET)` is hardwired high,
and `/WP` is hardwired low.

I've been able to write chips,
so apparently `/WP` is more of a suggestion than an actual protection.

#### For Noyito Carrier Board

I also have blank chips that come on Noyito brand carrier boards.
Here's how they're wired.

![pico-serprog_noyito_bb.svg](pico-serprog/pico-serprog_noyito_bb.svg)

[pico-serprog_noyito.fz](pico-serprog/pico-serprog_noyito.fz)

### References

* [Adafruit SPI FLASH Breakouts](https://learn.adafruit.com/adafruit-spi-flash-breakouts/pinouts)
* [DigiKey: W25 SpiFlash Series](https://www.digikey.com/en/product-highlight/w/winbond/w25-spiflash-series)
* [Winbond SpiFlash Memories with SPI, Dual-SPI, Quad-SPI and QPI](https://www.winbond.com/productResource-files/DA05-0006.pdf)

## SPI NAND Flash

It's different from NOR flash.
Apparently I don't have any programmer for it.

* flashrom doesn't do it, something about ECC.
* [PicoFlasher](https://consolemods.org/wiki/Xbox_360:PicoFlasher) requires J-Runner, which is for Windows.
* SNANDer doesn't seem to support W25N series

## eMMC

Not the same as MMC.
Also don't have the means to do it.


## Debugging the ROM Programmers

Want to see what's happening between the PC and programmer hardware?

### socat

Terminal 1:

```shell
socat -d -d pty,raw,echo=0 pty,raw,echo=0

2026/03/01 16:42:07 socat[144041] N PTY is /dev/pts/3
2026/03/01 16:42:07 socat[144041] N PTY is /dev/pts/4
2026/03/01 16:42:07 socat[144041] N starting data transfer loop with FDs [5,5] and [7,7]
```

Terminal 2:

```shell
sudo cat /dev/pts/3 | tee /dev/serial/by-id/usb-Raspberry_Pi_Pico_E660583883926031-if00 | xxd
```

Terminal 3:

```shell
sudo cat /dev/serial/by-id/usb-Raspberry_Pi_Pico_E660583883926031-if00 | tee /dev/pts/3 | xxd
```

Terminal 4:
```shell
./flashrom -p serprog:dev=/dev/pts/4 -V
flashrom v1.7.0-rc2 (git:v1.7.0-rc2-1-g000235b8) on Linux 6.12.62+rpt-rpi-2712 (aarch64)
flashrom is free software, get the source code at https://flashrom.org

flashrom was built with GCC 14.2.0, little endian
Command line (3 args): ./flashrom -p serprog:dev=/dev/pts/4 -V
Initializing serprog programmer
No baudrate specified, using the hardware's defaults.
serprog: connected - attempting to synchronize
.
serprog: Synchronized
serprog: Interface version ok.
serprog: Bus support: parallel=off, LPC=off, FWH=off, SPI=on
Warning: Automatic command availability check failed for cmd 0x08 - won't execute cmd
Warning: Automatic command availability check failed for cmd 0x11 - won't execute cmd
serprog: Programmer name is "pico-serprog"
serprog: Serial buffer size is 65535
serprog: Output drivers enabled
The following protocols are supported: SPI.
Probing for AMIC A25L010, 128 kB: compare_id: id1 0x0e, id2 0x4015
Probing for AMIC A25L016, 2048 kB: compare_id: id1 0x0e, id2 0x4015
Probing for AMIC A25L020, 256 kB: compare_id: id1 0x0e, id2 0x4015
...
Probing for XMC XM25QH512C/XM25QH512D, 65536 kB: serprog: requested mapping XM25QH512C/XM25QH512D is incompatible: 0x4000000 bytes at 0x00000000fc000000.
compare_id: id1 0x0e, id2 0x4015
Probing for XMC XM25QU512C/XM25QU512D, 65536 kB: serprog: requested mapping XM25QU512C/XM25QU512D is incompatible: 0x4000000 bytes at 0x00000000fc000000.
compare_id: id1 0x0e, id2 0x4015
Probing for XTX Technology Limited XT25F02E, 256 kB: compare_id: id1 0x0e, id2 0x4015
Probing for XTX Technology Limited XT25F64B, 8192 kB: compare_id: id1 0x0e, id2 0x4015
Probing for XTX Technology Limited XT25F128B, 16384 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Zbit Semiconductor, Inc. ZB25VQ16, 2048 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Zetta Device ZD25D20, 256 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Zetta Device ZD25D40, 512 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Zetta Device ZD25LQ128, 16384 kB: compare_id: id1 0x0e, id2 0x14
Probing for Unknown SFDP-capable chip, 0 kB: No SFDP signature found.
Probing for AMIC unknown AMIC SPI chip, 0 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Atmel unknown Atmel SPI chip, 0 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Eon unknown Eon SPI chip, 0 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Macronix unknown Macronix SPI chip, 0 kB: compare_id: id1 0x0e, id2 0x4015
Probing for PMC unknown PMC SPI chip, 0 kB: compare_id: id1 0x0e, id2 0x4015
Probing for SST unknown SST SPI chip, 0 kB: compare_id: id1 0x0e, id2 0x4015
Probing for ST unknown ST SPI chip, 0 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Sanyo unknown Sanyo SPI chip, 0 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Winbond unknown Winbond (ex Nexcom) SPI chip, 0 kB: compare_id: id1 0x0e, id2 0x4015
Probing for Generic unknown SPI chip (RDID), 0 kB: compare_id: id1 0x0e, id2 0x4015
Added layout entry 00000000 - ffffffff named complete flash
Found Generic flash chip "unknown SPI chip (RDID)" (0 kB, SPI) on serprog.
Probing for Generic unknown SPI chip (REMS), 0 kB: compare_id: id1 0x0e, id2 0x14
Found Generic flash chip "unknown SPI chip (RDID)" (0 kB, SPI).
===
This flash part has status NOT WORKING for operations: PROBE READ ERASE WRITE
This flash part has status UNTESTED for operations: WP
The test status of this chip may have been updated in the latest development
version of flashrom. If you are running the latest development version,
please email a report to flashrom@flashrom.org if any of the above operations
work correctly for you with this flash chip. Please include the flashrom log
file for all operations you tested (see the man page for details), and mention
which mainboard or programmer you tested in the subject line.
You can also try to follow the instructions here:
https://www.flashrom.org/contrib_howtos/how_to_mark_chip_tested.html
Thanks for your help!
No operations were specified.
serprog: Output drivers disabled
Runtime from programmer init to shutdown: 0min 1sec
```

Back on terminal 2, we see the captured data from flashrom to serprog

```shell
sudo cat /dev/pts/3 | tee /dev/serial/by-id/usb-Raspberry_Pi_Pico_E660583883926031-if00 | xxd
00000000: 0000 0000 0000 0000 1010 0102 0512 0812  ................
00000010: 0803 0415 0113 0100 0003 0000 9f13 0100  ................
00000020: 0004 0000 9f13 0100 0002 0000 1513 0100  ................
00000030: 0002 0000 1513 0100 0002 0000 1513 0100  ................
00000040: 0002 0000 1513 0100 0002 0000 1513 0100  ................
00000050: 0003 0000 9f13 0100 0003 0000 9f13 0100  ................
00000060: 0003 0000 9f13 0100 0003 0000 9f13 0400  ................
00000070: 0002 0000 ab00 0000 1304 0000 0200 0090  ................
00000080: 0000 0013 0400 0003 0000 8300 0000 1301  ................
00000090: 0000 0600 009f 1301 0000 0600 009f 1301  ................
000000a0: 0000 0600 009f 1301 0000 0600 009f 1301  ................
000000b0: 0000 0600 009f 1301 0000 0600 009f 1301  ................
000000c0: 0000 0600 009f 1301 0000 0600 009f 1304  ................
000000d0: 0000 0300 005a 0000 0013 0400 0003 0000  .....Z..........
```

And on terminal 3, we see the data from serprog to flashrom

```shell
sudo cat /dev/serial/by-id/usb-Raspberry_Pi_Pico_E660583883926031-if00 | tee /dev/pts/3 | xxd
00000000: 0606 0606 0606 0606 1506 1506 0601 0006  ................
00000010: 3f00 3d00 0000 0000 0000 0000 0000 0000  ?.=.............
00000020: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000030: 0608 0606 0670 6963 6f2d 7365 7270 726f  .....pico-serpro
00000040: 6700 0000 0006 ffff 0606 0e40 1506 0e40  g..........@...@
00000050: 150e 0600 0006 0000 0600 0006 0000 0600  ................
00000060: 0006 0e40 1506 0e40 1506 0e40 1506 0e40  ...@...@...@...@
00000070: 1506 1414 060e 1406 0000 0006 0e40 150e  .............@..
00000080: 4015 060e 4015 0e40 1506 0e40 150e 4015  @...@..@...@..@.
00000090: 060e 4015 0e40 1506 0e40 150e 4015 060e  ..@..@...@..@...
000000a0: 4015 0e40 1506 0e40 150e 4015 060e 4015  @..@...@..@...@.
```

So that works, but it doesn't show me the timings.

### Wireshark

Wireshark can capture USB traffic with the right setup.

Here's a capture of a different,
but equivalent interaction between [flashrom, serprog, and a Zbit chip](flashrom_to_serprog_to_zbit.pcapng).

### serprog Protocol

https://flashrom.org/supported_hw/supported_prog/serprog/serprog-protocol.html

Here's a manual decoding of the data captured by Wireshark.

| No. | Bytes from host (meaning)                                    | Bytes from serprog (meaning)                                                                                                     | Notes                                                                                    |
|-----|--------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| 35  | 0000000000000000 (8x NOP)                                    | 06 06 06 06 06 06 06 06 (8x ACK)                                                                                                 | The eight bytes from the host are in one bulk transfer. The responses are one at a time. |
| 53  | 10 (Sync NOP)                                                | 1506 (NAK+ACK)                                                                                                                   | NAK+ACK is the appropriate response                                                      |
| 59  | 10 (Sync NOP)                                                | 1506 (NAK+ACK)                                                                                                                   | NAK+ACK is the appropriate response                                                      |
| 65  | 01 (version?)                                                | 06 0100 (ACK, v1.00)                                                                                                             |                                                                                          |
| 73  | 02 (commands?)                                               | 06 3f00 3d00 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 0000 (ACK, supports commands 2-7, 0x12-0x15, 0x17) |                                                                                          |
| 117 | 05 (bustype?)                                                | 06 08 (ACK, SPI)                                                                                                                 |                                                                                          |
| 123 | 1208 (bustype=SPI)                                           | 06 (ACK)                                                                                                                         |                                                                                          |
| 128 | 1208 (bustype=SPI)                                           | 06 (ACK)                                                                                                                         |                                                                                          |
| 132 | 03 (name?)                                                   | 06 7069636f2d73657270726f670000000 (ACK, pico-serprog\0\0\0\0)                                                                   | 16 bytes string, null padded                                                             |
| 138 | 04 (buffer size?)                                            | 06 ffff (ACK, 64 KiB -1)                                                                                                         | Buffer is effectively 64 KiB, max representable size                                     |
| 144 | 1501 (enable pin drivers)                                    | 06 (ACK, enable drivers)                                                                                                         | Disable would be hi-z state.                                                             |
| 148 | 13 010000 030000 9f (spi write 0x9f, read 3 bytes)           | 06 0e4015 (ACK, 0e4015)                                                                                                          |                                                                                          |
| 154 | 13 010000 040000 9f (spi write 0x9f, read 4 bytes)           | 06 0e40150e (ACK, 0e40150e)                                                                                                      |                                                                                          |
| 160 | 13 010000 020000 15 (spi write 0x15, read 2 bytes)           | 06 0000 (ACK, 0000)                                                                                                              |                                                                                          |
| 166 | 13 010000 020000 15 (spi write 0x15, read 2 bytes)           | 06 0000 (ACK, 0000)                                                                                                              |                                                                                          |
| 172 | 13 010000 020000 15 (spi write 0x15, read 2 bytes)           | 06 0000 (ACK, 0000)                                                                                                              | Might be retrying in case of bad read, because the response was 0x0000.                  |
| 178 | 13 010000 020000 15 (spi write 0x15, read 2 bytes)           | 06 0000 (ACK, 0000)                                                                                                              |                                                                                          |
| 184 | 13 010000 020000 15 (spi write 0x15, read 2 bytes)           | 06 0000 (ACK, 0000)                                                                                                              |                                                                                          |
| 190 | 13 010000 030000 9f (spi write 0x9f, read 3 bytes)           | 06 0e4015 (ACK, 0e4015)                                                                                                          |                                                                                          |
| 196 | 13 010000 030000 9f (spi write 0x9f, read 3 bytes)           | 06 0e4015 (ACK, 0e4015)                                                                                                          |                                                                                          |
| 202 | 13 010000 030000 9f (spi write 0x9f, read 3 bytes)           | 06 0e4015 (ACK, 0e4015)                                                                                                          |                                                                                          |
| 208 | 13 010000 030000 9f (spi write 0x9f, read 3 bytes)           | 06 0e4015 (ACK, 0e4015)                                                                                                          |                                                                                          |
| 214 | 13 040000 020000 ab000000 (spi write ab000000, read 2 bytes) | 06 1414 (ACK, 1414)                                                                                                              |                                                                                          |
| 220 | 13 040000 020000 90000000 (spi write 90000000, read 2 bytes) | 06 0e14 (ACK, 0e14)                                                                                                              |                                                                                          |
| 226 | 13 040000 030000 83000000 (spi write 83000000, read 3 bytes) | 06 000000 (ACK, 000000)                                                                                                          |                                                                                          |
| 232 | 13 010000 060000 9f (spi write 0x9f, read 6 bytes)           | 06 0e40150e4015 (ACK, 0e4015 x2)                                                                                                 |                                                                                          |
| 238 | 13 010000 060000 9f (spi write 0x9f, read 6 bytes)           | 06 0e40150e4015 (ACK, 0e4015 x2)                                                                                                 |                                                                                          |
| 244 | 13 010000 060000 9f (spi write 0x9f, read 6 bytes)           | 06 0e40150e4015 (ACK, 0e4015 x2)                                                                                                 |                                                                                          |
| 250 | 13 010000 060000 9f (spi write 0x9f, read 6 bytes)           | 06 0e40150e4015 (ACK, 0e4015 x2)                                                                                                 |                                                                                          |
| 256 | 13 010000 060000 9f (spi write 0x9f, read 6 bytes)           | 06 0e40150e4015 (ACK, 0e4015 x2)                                                                                                 |                                                                                          |
| 262 | 13 010000 060000 9f (spi write 0x9f, read 6 bytes)           | 06 0e40150e4015 (ACK, 0e4015 x2)                                                                                                 |                                                                                          |
| 268 | 13 010000 060000 9f (spi write 0x9f, read 6 bytes)           | 06 0e40150e4015 (ACK, 0e4015 x2)                                                                                                 |                                                                                          |
| 274 | 13 010000 060000 9f (spi write 0x9f, read 6 bytes)           | 06 0e40150e4015 (ACK, 0e4015 x2)                                                                                                 |                                                                                          |
| 280 | 13 040000 030000 5a000000 (spi write 5a000000, read 3 bytes) | 06 000000 (ACK, 000000)                                                                                                          |                                                                                          |
| 286 | 13 040000 030000 5a000002 (spi write 5a000002, read 3 bytes) | 06 0000 (ACK, 0000)                                                                                                              |                                                                                          |
| 292 | 1500 (disable pin drivers)                                   | 06 (ACK)                                                                                                                         |                                                                                          |

130400000300005a000002