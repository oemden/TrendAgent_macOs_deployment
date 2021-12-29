#!/bin/bash
## oem at oemden dot com
# create the package
# Now with receipt and thus version thx to https://managingosx.wordpress.com/2015/05/20/pseudo-payload-free-pkgs-with-pkgbuild/
# Adding a restart action so we're warned (as it reboots with no warning) : https://managingosx.wordpress.com/2012/07/05/stupid-tricks-with-pkgbuild/
# Trend Info here:
#  https://success.trendmicro.com/solution/1114085-mac-mass-deployment-in-worry-free-business-security-services-wfbs-svc#
version="1.0" #

################## EDIT START #######################
CompanyName="myCompany"
deploymentPkgVersion="1.0"
################# EVENTUALLY EDIT ###################
pkg_identifier="com.${CompanyName}.deploy.WFBS-SVC_Agent.pkg"
pkg_name="${CompanyName}.deploy-WFBS-SVC_Agent_Installer.${deploymentPkgVersion}.pkg"
################## EDIT STOP ########################

#####################################################
my_path=`dirname ${0}`
my_name=`basename ${0}`
my_absolutepath="$(cd '${my_path}' ; pwd -P )"
TrendCorpIdentifier="${1}"
WFBS_SVC_Agent_Installer="${2}"
WFBS_SVC_Agent_Installer_name=`basename $2`
#####################################################

function help {
 echo "Missing Trend Identifier and/or Trend Agent pkg"
 echo " Please use script as follow:"
 echo " ./${my_name} myCompany_Identifier /path/to/WFBS-SVC_Agent_Installer.pkg.zip"
 echo
 echo " more info in the Readme and here: "
 echo " https://success.trendmicro.com/solution/1114085-mac-mass-deployment-in-worry-free-business-security-services-wfbs-svc#"
}

# Check variables
if [[ ! "${1}" ]] ; then
 echo " Please Provide the Company Identifier"
 help
 exit 1
fi

if [[ ! "${2}" ]] ; then
 echo " Please Provide the WFBS-SVC_Agent_Installer.pkg.zip path"
 help
 exit 1
fi

#####################################################
clear ; echo
#echo "${my_path}"
cd "${my_path}"
mkdir -p ./root/var/tmp/TrendMicro
mkdir -p ./{scripts,inf}
#####################################################

function echovars {
 echo "	my_path: ${my_path}"
 echo "	my_absolutepath: ${my_absolutepath}"
 echo "	my_name: ${my_name}"
 echo "	pkg_identifier: ${pkg_identifier}"
 echo "	pkg_name: ${pkg_name}"
 echo "	TrendCorpIdentifier: ${TrendCorpIdentifier}"
 echo "	WFBS_SVC_Agent_Installer: ${WFBS_SVC_Agent_Installer}"
 echo "	WFBS_SVC_Agent_Installer_name: ${WFBS_SVC_Agent_Installer_name}"
}

function createIdentifierplist () {
 defaults write "${my_absolutepath}"/root/var/tmp/TrendMicro/Identifier.plist Identifier "${TrendCorpIdentifier}"
}

function copyAgent () {
 ditto "${WFBS_SVC_Agent_Installer}" "${my_absolutepath}"/root/var/tmp/TrendMicro/
}

function createPostinstallscript () {
 cat > "scripts/postinstall"  <<EOF
#!/bin/bash
## oem at oemden dot com
## deploy Trend Agent on Os X
# v${version}
#  https://success.trendmicro.com/solution/1114085-mac-mass-deployment-in-worry-free-business-security-services-wfbs-svc#

## Prefix all paths with
if [ "\$3" == "/" ]; then
    TARGET=""
else
    TARGET="\$3"
fi

TrendIdentifier="\${TARGET}/var/tmp/TrendMicro/Identifier.plist"

## must run sudo
my_id="\$(id -u)"
if [[ "\${my_id}" -ne 0 ]] ; then
 printf " == Must be run as sudo, exiting == "
 echo
 exit 1
fi

if [[ ! "\${TrendIdentifier}" ]] ; then
 echo " == Missing \${TrendIdentifier}, exiting == "
 exit 1
fi

## unzip the Trend Agent .pkg
ditto -xk "\${TARGET}"/var/tmp/TrendMicro/WFBS-SVC_Agent_Installer.pkg.zip "\${TARGET}"/var/tmp/TrendMicro/
# let's sleep a bit...
sleep 10
## install the Agent pkg
installer -pkg "\${TARGET}"/var/tmp/TrendMicro/WFBS-SVC_Agent_Installer.pkg -tgt /

#Clean Up
rm -f "\${TrendIdentifier}"
rm -f "\${TARGET}"/var/tmp/TrendMicro/WFBS-SVC_Agent_Installer*

exit 0

EOF

chmod +x scripts/postinstall
}

function createPackageInfo () {
cat > inf/PackageInfo <<EOF
<?xml version="1.0" encoding="utf-8" standalone="no"?>
<pkg-info postinstall-action="restart"/>

EOF
}

function createDeploymentPkg () {
## Restart not needed after all
 #pkgbuild --root root --info inf/PackageInfo --scripts scripts --identifier "${pkg_identifier}" --version "${deploymentPkgVersion}" "${pkg_name}"
 pkgbuild --root root --scripts scripts --identifier "${pkg_identifier}" --version "${deploymentPkgVersion}" "${pkg_name}"
}

function cleanThisUp {
echo
rm -Rf ./{root,scripts,inf}
}

################# Do_It ############################
echo "	Creating pkg ${pkg_name} " ; echo

createIdentifierplist
copyAgent
createPostinstallscript
#createPackageInfo
createDeploymentPkg
cleanThisUp
echo ; echo "	Package ${pkg_name} created "

## Open the containing folder
echo ; echo "	Opening folder ${my_absolutepath}" ; open ./ ; echo

exit 0
