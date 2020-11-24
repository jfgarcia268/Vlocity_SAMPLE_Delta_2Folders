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


echo "####### packDeploy"
vlocity -sfdx.username "$ALIAS" -job DeployEPC.yaml packDeploy --verbose true --simpleLogging true