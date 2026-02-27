# Firmware

I've learned some things about firmware through these hacks.

## ROM Chips

The firmware has almost always been on a SPI NOR flash chip,
typically in an SOIC-8 or SOP-8 package.
I think there was one 16-pin ROM.
The chip's size and features depend on the complexity and era of the device.
I've looked at a time range from approximately 2006 to 2018.
The earlier devices were 2-4 MiB (16-32 Mib) dual-SPI type flash ROMs,
with part numbers like W25S16, W25S32.

The middle period typically had 4-8 MiB (32-64 Mib) quad-SPI flash ROMs:
W25Q32, W25Q64.

Later and higher-end products had higher-capacity flash chips
and supported higher frequencies like 133 MHz.
8-16 MiB (64-128 Mib) quad-SPI flash ROMs, W25Q64, W25Q128.

One device, the eero Pro, also had an eMMC storage.
I suspect that the 8-pin SPI flash continues to be sufficient
for the lower side of consumer-grade routers.
For devices looking to increase storage capacity and performance,
eMMC is the next logical step.
It looks like SPI NOR ROMs are topping out at quad-SPI.
eMMC has eight I/O pads, so what's the point of an octo-SPI flash ROM.

## Formats

It appears that the format of the flash ROM is almost always dependent on the SoC.
Each product has custom firmware from the product manufacturer,
but they always use the SoC manufacturer's SDK.

The SDK seems to dictate the bootloader,
the layout of the ROM,
the operating system,
and the compiler used.

Thus, when inspecting a firmware image,
it helps to know what SoC it was made for,
and the SDK's conventions.
