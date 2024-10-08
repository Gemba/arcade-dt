/*
 * defines gpio port number to event code for I2C/MCP23017 connected joysticks
 *
 * Copyright (c) 2024 Gemba @ GitHub
 * SPDX-License-Identifier: GPL-2.0-only
 */
#ifndef _ARCADE_DT_MCP_PORT_MAP_
#define _ARCADE_DT_MCP_PORT_MAP_

/*
 * see: dt-bindings/input/linux-event-codes.h for button defines
 * a == south, b == east, x == north, y == west
 * port 15 is spare
 */
#define ARCADE_DT_MCP_PORT_MAP \
                up     { linux,code = <BTN_DPAD_UP>;    gpios = <&mcp23017 0 GPIO_ACTIVE_LOW>;  label = "BTN_DPAD_UP"; };\
                down   { linux,code = <BTN_DPAD_DOWN>;  gpios = <&mcp23017 1 GPIO_ACTIVE_LOW>;  label = "BTN_DPAD_DOWN"; };\
                left   { linux,code = <BTN_DPAD_LEFT>;  gpios = <&mcp23017 2 GPIO_ACTIVE_LOW>;  label = "BTN_DPAD_LEFT"; };\
                right  { linux,code = <BTN_DPAD_RIGHT>; gpios = <&mcp23017 3 GPIO_ACTIVE_LOW>;  label = "BTN_DPAD_RIGHT"; };\
                start  { linux,code = <BTN_START>;      gpios = <&mcp23017 4 GPIO_ACTIVE_LOW>;  label = "BTN_START"; };\
                select { linux,code = <BTN_SELECT>;     gpios = <&mcp23017 5 GPIO_ACTIVE_LOW>;  label = "BTN_SELECT"; };\
                a      { linux,code = <BTN_A>;          gpios = <&mcp23017 6 GPIO_ACTIVE_LOW>;  label = "BTN_A"; };\
                b      { linux,code = <BTN_B>;          gpios = <&mcp23017 7 GPIO_ACTIVE_LOW>;  label = "BTN_B"; };\
                x      { linux,code = <BTN_X>;          gpios = <&mcp23017 8 GPIO_ACTIVE_LOW>;  label = "BTN_X"; };\
                y      { linux,code = <BTN_Y>;          gpios = <&mcp23017 9 GPIO_ACTIVE_LOW>;  label = "BTN_Y"; };\
                tl     { linux,code = <BTN_TL>;         gpios = <&mcp23017 10 GPIO_ACTIVE_LOW>; label = "BTN_TL"; };\
                tr     { linux,code = <BTN_TR>;         gpios = <&mcp23017 11 GPIO_ACTIVE_LOW>; label = "BTN_TR"; };\
                tl2    { linux,code = <BTN_TL2>;        gpios = <&mcp23017 12 GPIO_ACTIVE_LOW>; label = "BTN_TL2"; };\
                tr2    { linux,code = <BTN_TR2>;        gpios = <&mcp23017 13 GPIO_ACTIVE_LOW>; label = "BTN_TR2"; };\
                hk     { linux,code = <BTN_MODE>;       gpios = <&mcp23017 14 GPIO_ACTIVE_LOW>; label = "BTN_MODE"; };
#endif