# docs/tools

This directory is for documentation about tools.

Some tools are better than others.
Here are some of my findings

## ROM Programmers/Readers

### flashrom

[flashrom](https://www.flashrom.org/) seems to be the de-facto standard application
for reading/writing/etc. ROM chips.
It requires appropriate hardware to actually execute an operation,
but is compatible with a number of hardware devices.

flashrom seems to be focused on serial NOR flash.
I think I might have used it on serial EEPROMs as well.
It supposedly works on parallel interfaces, but I haven't seen it in action.
I've been told it doesn't work for NAND flash,
but also saw things in the code that implies it does support NAND flash.

(Compatibility matrix goes here)

flashrom works a lot of the time.
When it doesn't work out-of-the-box, it can get quite tedious.
I added support for a Zbit chip,
and [submitted it to the upstream project](https://review.coreboot.org/c/flashrom/+/91555).

The chip configuration itself isn't that bad.
There's a learning curve, but a bit of reading can sort it out.
When the datasheet and chip don't match, that's a hassle.

I'll refrain from detailing my grievances here.
Suffice to say that had to hold my nose through every change the maintainer required.

In all, it was a very difficult experience and tremendously wasteful in so many ways.
I'll think twice before doing it again.

I think flashrom is one of those projects that has become entrenched
by being good enough for some important use cases,
despite being mediocre software.
Those entrusted with care of the "official" version aren't in a situation to really fix it,
and don't trust anyone else to fix it either,
so it remains.

I think entrenched mediocrity is a typical least-energy state for open-source software.
I heard that Linux used to be that way but it's better now.
OpenSSL was infamous for it, with catastrophic results.

See https://xkcd.com/1172/.
