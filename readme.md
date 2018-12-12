#Create Deployment Package for Trend agent Security ( for macOs )

This script will create a ready to deploy Package for Mac Mass Deployment of Worry-Free Business Security Services (WFBS-SVC). 

## #Step 1

Follow step1 & step2 from :

https://success.trendmicro.com/solution/1114085-mac-mass-deployment-in-worry-free-business-security-services-wfbs-svc#


1. **Get your trend Agent** `Identifier` (Step 1)
2. **Download the Package** `WFBS-SVC_Agent_Installer.pkg.zip` (Step 2) **Note:** keep it as a zip file.


## #Step 2

**Edit the script** `Create_Deployment_Package_for_Trend_agent_Security_for_macOs.sh`

- Company Name: `CompanyName`
- Package Versioning: `deploymentPkgVersion`
 
*( It is always better to get versioning of your deployment package - in case of future Agent Updates )*


**Optionnally edit**

- The Package Identifier: `pkg_identifier`
- The Package Name: `pkg_name`

## #Step 3

Run the script with the Identifier as **first argument** and the Agent package path as **second argument**

```
./Create_Deployment_Package_for_Trend_agent_Security_for_macOs.sh "MyCompanyIdentifier" /path/to/WFBS-SVC_Agent_Installer.pkg
```

example:

```
./Create_Deployment_Package_for_Trend_agent_Security_for_macOs.sh "ZJpGUivCEY6dyuTRf8lhWw==fJYgdiDGwO7Ct6ib/V2cImjxpqOr2whXfW5YyvNkfvTJ6daaPCbNi25+atIlazW7xlScqw/3AF2NAQdcd+47GcfEqUKL9ojcOcAh+dGTjjMxD2Tzd" ~/Downloads/WFBS-SVC_Agent_Installer.pkg.zip
```

## #Step 4
Import in your favorite deployment tool like munki or jamf...

