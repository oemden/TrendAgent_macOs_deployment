#!/bin/bash
## oem at oemden dot com

version="1.4" ## Works as standalone
clear ; echo

## must run sudo
my_id="$(id -u)"
if [[ "${my_id}" -ne 0 ]] ; then
 printf " == Must be run as sudo, exiting == "
 echo
 exit 1
fi

## Prefix all paths with
if [ "$3" == "/" ]; then
    TARGET=""
else
    TARGET="$3"
fi

TrendIdentifier_plist_dir="${TARGET}/var/tmp/TrendMicro"

#Clean Up
rm -rf "${TrendIdentifier_plist_dir}"

exit 0
