GIT_DIR := $(shell git rev-parse --show-toplevel)
include $(GIT_DIR)/device.sh

RESET_BIN_FILENAME=$(DEV_TAG_SC).reset.bin
BIN_FILENAME=$(DEV_TAG_SC).bin

FW_DIR=$(GIT_DIR)/../../firmware-copyrighted/$(DEV_TAG)
RESET_BIN_PATH=$(FW_DIR)/$(RESET_BIN_FILENAME)
BIN_PATH=$(FW_DIR)/$(BIN_FILENAME)


all:

reset: $(RESET_BIN_FILENAME)

bin: $(BIN_FILENAME)

$(FW_DIR):
	mkdir -p $(FW_DIR)

$(RESET_BIN_FILENAME): $(RESET_BIN_PATH)
	ln -s $(RESET_BIN_PATH) $(RESET_BIN_FILENAME)

$(RESET_BIN_PATH): $(FW_DIR)
	flashrom_dump $(RESET_BIN_PATH)
	LANG=C bin2hex $(RESET_BIN_PATH)

$(BIN_FILENAME): $(BIN_PATH)
	ln -s $(BIN_PATH) $(BIN_FILENAME)

$(BIN_PATH): $(FW_DIR)
	flashrom_dump $(BIN_PATH)
	LANG=C bin2hex $(BIN_PATH)
