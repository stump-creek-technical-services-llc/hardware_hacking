# This scripts processes the FLAVOR input for make scripts

# FLAVOR is a qualifier used on device states, usually ROM images.
# The default is FLAVOR=""
# For a device that has been factory reset and has not been configured, FLAVOR="reset"
# For a ROM update image, FLAVOR="update"

# Set FLAVOR_BIN_EXT, the extension used on ROM images for this FLAVOR
ifeq ($(FLAVOR),)
    FLAVOR_BIN_EXT = bin
    $(info FLAVOR is default)
else
    FLAVOR_BIN_EXT = $(FLAVOR).bin
    $(info FLAVOR is "$(FLAVOR)")
endif
