# Create Deployment Package for Trend agent Security ( for macOs )


I previoulsly made a script to create a ready to deploy Package for Mac Mass Deployment of Worry-Free Business Security Services (WFBS-SVC). Due to restrictions with recents macOs this does not work anymore.

Change of plans and it is finally much simpler.



## Step 1: get the TrendMicro install .pkg and Identifier


https://success.trendmicro.com/solution/1114085-mac-mass-deployment-in-worry-free-business-security-services-wfbs-svc#


1. **Get your trend Agent** `Identifier` (Step 1)
2. **Download the Package** `WFBS-SVC_Agent_Installer.pkg.zip` (Step 2) **Note:** keep it as a zip file.


IMPORTANT Note: I had the Identifier.plist in the .zip with the last download to date.

It was DIFFERENT from the one on  the console, total waste of time. 

The working one is of course the one within the .zip file

## Step 2: munki scripts

### 2.1 preinstall script:

`munki-trendMicro-macOs-preinstall_script.sh` is here to create the Identifier.plist via munki.

- Edit the variable `TrendCorpIdentifier` like so:

`TrendCorpIdentifier="WozQPkqjc>gyv8U8A]W&d]9YNf=>pabAveuKn7z8PGzKbHh^tAWozQPkqjc>gyv8U8A]W&d]9YNf=>pabAveuKn7z8PGzKbHh^tAWozQPkqjc>gyv8U8A]W&d]9YNf=>pabAveuKn7z8PGzKbHh^tATcOQ=="`

### 2.2 postinstall script

 `munki-trendMicro-macOs-postinstall_script.sh` is to clean things up.
 
### 2.3 Bonus: Uninstall script

If you ever want to uninstall automagically Trend... Good luck.

One of my cleint waited too  long and the Identifier changed. 
It has been a nightmare, I had to uninstall first Trend then reinstall it.

`munki-trendMicro-macOs-uninstall_script.sh` is an ongoing work to remove Trend micro automatically.

## Step 3: munki import

Unzip `WFBS-SVC_Agent_Installer.zip` into the working folder and import the package `WFBS-SVC_Agent_Installer.pkg` in munki calling switches :

```
cd /some/path/to/here
munkiimport ./WFBS-SVC_Agent_Installer.pkg \
--preinstall_script=munki-trendMicro-macOs-preinstall_script.sh \
--postinstall_script=munki-trendMicro-macOs-postinstall_script.sh \
--uninstall_script=munki-trendMicro-macOs-uninstall_script.sh \
```


