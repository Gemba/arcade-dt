# Makefile to compile and install devicetree binary overlays.
#
# Note: make to be run in the folder of this Makefile
#
# Source files:
# - gpio-joystick.dts: preprocessed once to replace defines
#
# - gpio-mcp-joystick-tpl.dts: preprocessed once to replace local defines and
#   the ones from evdev (creates gpio-mcp-joystick-stub.dts), then merged with
#   existing mcp23017-overlay.dts from upstream. The merge creates
#   gpio-mcp-joystick.dts.
#
# The gpio-joystick.dts and gpio-mcp-joystick.dts are then compiled to device
# tree binaries (*.dtbo).
#
# Copyright (c) 2024 Gemba @ GitHub
# SPDX-License-Identifier: GPL-2.0-only

CXX := cpp
CFLAGS := -nostdinc -undef -x assembler-with-cpp

KVERSION_MAJOR_MINOR := $(shell uname -r | cut -f 1,2 -d '.')
KVERSION_MAJOR := $(word 1,$(subst ., ,$(KVERSION_MAJOR_MINOR)))

DTC_FLAGS := --symbols -I dts -O dtb --warning no-unit_address_vs_reg
ifeq ($(KVERSION_MAJOR), 6)
	DTC_FLAGS += --warning no-interrupt_provider
endif

INCLUDES := $(shell find /usr/src -type d -name "linux-headers-$(KVERSION_MAJOR).*-common*" | head -n 1)
ifeq ($(INCLUDES),)
	INCLUDES += $(shell find /usr/src -name "linux-event-codes.h" | head -n 1 | rev | cut -d / -f 5- | rev)
endif
INCLUDES += $(shell pwd)

INSTALL_DIR := /boot/overlays

OVMERGE := ./ovmerge

DTBOS := gpio-joystick.dtbo gpio-mcp-joystick.dtbo

SED_CLEAN := '/^\#.*$$/d' '/^$$/d'

MERGE_BASE := mcp23017-overlay.dts
MERGE_WITH := gpio-mcp-joystick-stub.dts
MERGE_DEST := gpio-mcp-joystick.dts

all: merge $(DTBOS)

merge:
	@echo "[*] Merging ..."
	@echo "[*] Kernel version detected: $(KVERSION_MAJOR_MINOR)"
	@echo "[*] Include folders: $(INCLUDES:%=\n    %/include)\n"
	wget -q -O $(MERGE_BASE) https://raw.githubusercontent.com/raspberrypi/linux/refs/heads/rpi-$(KVERSION_MAJOR_MINOR).y/arch/arm/boot/dts/overlays/mcp23017-overlay.dts
	$(CXX) $(INCLUDES:%=-I%/include) $(CFLAGS) gpio-mcp-joystick-tpl.dts \
		| sed $(SED_CLEAN:%=-e %) -e 's/}; /};\n                /g' \
		> $(MERGE_WITH)
	perl $(OVMERGE) -S 4 $(MERGE_BASE) $(MERGE_WITH) > $(MERGE_DEST)

$(DTBOS): %.dtbo: %.dts
	@echo "[*] Compiling DTBO ..."
	$(CXX) $(INCLUDES:%=-I%/include) $(CFLAGS) $^ | dtc $(DTC_FLAGS) -o $@

clean:
	rm -f $(DTBOS) $(MERGE_BASE) $(MERGE_WITH) $(MERGE_DEST)

install: all
	@echo "[*] Installing ..."
	cp $(DTBOS) $(INSTALL_DIR)

uninstall:
	@echo "[*] Uninstalling ..."
	$(foreach dtbo, $(DTBOS), rm -f $(INSTALL_DIR)/$(dtbo))
