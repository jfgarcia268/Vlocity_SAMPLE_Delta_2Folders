#!/usr/bin/env bash

#---------------------------------------------
#Date: 10/23/2020
#Code by: Juan Felipe Garcia
#---------------------------------------------

echo "####### Login"
echo ${SFDX_URL} > env.sfdx
ALIAS=${SFDX_URL}
sfdx force:auth:sfdxurl:store -d -a "${ALIAS}" -f env.sfdx
rm -rf env.sfdx

echo "####### Create SF Delta Package"
echo "y" | sfdx plugins:install vlocityestools

if [ -d force-app_delta ]; then
    rm -rf force-app_delta  
fi

sfdx vlocityestools:sfsource:createdeltapackage -u "${ALIAS}" -p cmt -d force-app --gitcheckkey=vlocity


if [ -d force-app_delta ]; then
    echo "####### force:source:deploy"
	sfdx force:source:deploy --sourcepath force-app_delta --targetusername "${ALIAS}" --verbose
else
	echo "### NO SF DELTA-FOLDER FOUND"
fi

echo "####### packDeploy"
vlocity -sfdx.username "$ALIAS" -job DeployVlocity.yaml packDeploy --verbose true --simpleLogging true

