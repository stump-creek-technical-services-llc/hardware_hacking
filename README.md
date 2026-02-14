# Hardware Hacking

This is a parent repo for my collection of hardware hacking projects.
These projects involve opening and exploring existing devices.

The usual process is:
1. Create a device-specific repo and add it to the index
2. Document the device before opening.
3. Open the case.
4. Document and identify the internal parts: boards, chips.
5. Dump the ROM device.
   1. The original goes to the `firmware-nonfree` repo. 
   2. FOSS portions of the firmware are identified and extracted into a free firmware.
   3. The free firmware is included in the device-specific repos.
6. Parse the firmware:
   1. binwalk
   2. Generate a partition table and matching firmware
   3. Extract partitions

**!! IMPORTANT !!**  
***I am not a lawyer. This is not legal advice.***  
Device firmware is initially assumed to be proprietary and not freely distributable,
so they go into a separate, non-public repo.
However, many firmwares are subsequently found to contain FOSS, and those components can be shared:

* [Linux kernel is GPLv2](https://www.kernel.org/doc/html/v4.19/process/license-rules.html)
* [BusyBox is GPLv2](https://www.busybox.net/license.html)

Free firmware may be included in device-specific repos.

## Policies
* The `.bin` filename extension is used for firmware images and fragments thereof.
* Firmware is assumed to be non-free unless it is confirmed to be free.
When it's confirmed to be free, name it matching the glob `*-free*`.
***DO NOT*** name non-free files `*-non-free*`, because that also matches the `*-free` glob.
* Directories for firmware data must use `.gitignore` to ensure that no non-free software will appear in the repo.
* Firmware manipulations should be scripted, 
so that they can easily be repeated with different versions of the firmware,
i.e. free and non-free.
