#!/bin/sh
## oem at oemden dot com
## helpfull sources:

## NOT TrendMicro
## https://apple.stackexchange.com/questions/350748/how-do-i-uninstall-trend-micro-security-agent
## and mostly https://community.jamf.com/t5/jamf-pro/uninstall-trend-micro-security-script/td-p/199713

version="1.2" #

# To be used as a uninstall script in munki ( munkiimport )

# mods from script:
# Copyright:       EVRY
# Filename:        UninstallTrend.sh
# Requires:        -
# Purpose:         Removes Trend Micro Security
# Contact:        Anders Holmdahl <anders.holmdahl@evry.com>
# Mod history:    2018-01-31

# v2 adding launchAgents

launchctl unload /Library/LaunchDaemons/com.trendmicro.icore.av.plist
launchctl unload /Library/LaunchAgents/com.trendmicro.*

rm -rf/Library/LaunchDaemons/com.trendmicro.*
rm -rf /Library/LaunchAgents/com.trendmicro.*
rm -rf /Library/Application \Support/TrendMicro
rm -rf /Library/Frameworks/TMAppCommon.framework
rm -rf /Library/Frameworks/TMAppCore.framework
rm -rf /Library/Frameworks/TMGUIUtil.framework
rm -rf /Library/Frameworks/iCoreClient.framework
rm -rf /Applications/TrendMicroSecurity.app

killall -kill TmLoginMgr
killall -kill UIMgmt

## Remove All Trend receipts
pkgutil --forget com.trendmicro.icore.autostart.pkg
pkgutil --forget com.trendmicro.icore.kextention.pkg
pkgutil --forget com.trendmicro.icore.service.pkg
pkgutil --forget com.trendmicro.tmsm.application.trendMicroSecurity.tmcoreinst.pkg
pkgutil --forget com.trendmicro.tmsm.application.trendMicroSecurity.tmsecurity.pkg
pkgutil --forget com.trendmicro.tmsm.application.trendMicroSecurity.tmsecurityextra.pkg
pkgutil --forget com.trendmicro.tmsm.tmappextra

exit 0
