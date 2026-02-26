# pico-serprog

https://github.com/stacksmashing/pico-serprog

##  Pinout

| GPIO | Pico Pin | Function |
|------|----------|----------|
| 1    |    2     | CS       |
| 2    |    4     | SCK      |
| 3    |    5     | MOSI     |
| 4    |    6     | MISO     |

## Usage

Dump a flashchip:

```
flashrom -p serprog:dev=/dev/tty.usbmodem21301:115200,spispeed=2M -r foo.bin
```
