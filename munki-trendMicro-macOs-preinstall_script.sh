#!/bin/bash
## oem at oemden dot com
## Use as a preinstall_script in munki to create the Needed Identifier.plist for the Install to run as expected.
## previous method with a custom .pkg installing the .pkg is not valid anymore in macOs.
# old Trend Info here:
#  https://success.trendmicro.com/solution/1114085-mac-mass-deployment-in-worry-free-business-security-services-wfbs-svc#
version="1.4" ## Works as standalone
clear ; echo

echo "Create Trend Identifier plist"

## must run sudo
my_id="$(id -u)"
if [[ "${my_id}" -ne 0 ]] ; then
 printf " == Must be run as sudo, exiting == "
 echo
 exit 1
fi

################## EDIT START #######################
TrendCorpIdentifier="WozQPkqjc>gyv8U8A]W&d]9YNf=>pabAveuKn7z8PGzKbHh^tAWozQPkqjc>gyv8U8A]W&d]9YNf=>pabAveuKn7z8PGzKbHh^tAWozQPkqjc>gyv8U8A]W&d]9YNf=>pabAveuKn7z8PGzKbHh^tATcOQ=="
################## EDIT STOP ########################
#####################################################

## Prefix all paths with
if [ "$3" == "/" ]; then
    TARGET=""
else
    TARGET="$3"
fi

TrendIdentifier_plist_dir="${TARGET}/var/tmp/TrendMicro"
TrendIdentifier_plist="${TrendIdentifier_plist_dir}/Identifier.plist"

### Create working directory
mkdir -p "${TrendIdentifier_plist_dir}"
#####################################################

## Create Identifier.plist
defaults write "${TrendIdentifier_plist}" Identifier "${TrendCorpIdentifier}"

#Clean Up
rm -rf "${TrendIdentifier_plist_dir}"

exit 0
