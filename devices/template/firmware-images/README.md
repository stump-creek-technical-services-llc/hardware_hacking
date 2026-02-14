# firmware-links

This directory is for ***symbolic links*** to available firmware.
***DO NOT*** put firmware files themselves in this directory.
This directory uses `.gitignore` to help prevent accidental commits.

When a free firmware image is generated:
1. Add it to the firmware-free directory, named as `*-free.bin`.
2. Create a symbolic link from this directory to that one.
3. Add the symbolic link to git, retaining the `*-free.bin` name.
You'll have to force it: `git add -f myfirmware-free.bin`

If you have access to non-free firmware,
you can overwrite the symbolic links in this directory with symbolic links to your non-free firmware.
The `.gitignore` settings will help ensure that you don't commit your link,
so that this repo remains usable by those with only the free firmware.
