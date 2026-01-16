#! /usr/bin/env bash

# One-time setup to build Arcade DT drivers.

# Copyright (c) 2026 Gemba @ GitHub
# SPDX-License-Identifier: GPL-2.0-only

git submodule init
git submodule update

deps=(cpp device-tree-compiler make gpiod evtest)

kernel=$(uname -r | cut -f 2- -d'-')
if LANG=C apt-cache policy "linux-headers-$kernel" | grep -q Version  ; then
    deps+=("linux-headers-$kernel")
else
    # RetroPie Buster
    deps+=(linux-headers-rpi)
fi
sudo apt -y install "${deps[@]}"
