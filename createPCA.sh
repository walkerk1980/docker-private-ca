#!/bin/bash

random-token()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-20} | head -n 1
}

caconfig=/root/pca/pca_config.json
revokecfg=/root/pca/pca_revoke_config.json
random_token=$(random-token)

command="aws acm-pca create-certificate-authority"
command+=" --certificate-authority-configuration file://$caconfig"
command+=" --revocation-configuration file://$revokecfg"
command+=" --certificate-authority-type \"SUBORDINATE\"" 
command+=" --idempotency-token $random_token"

if [ ! -z "$1" ];then
 command+=" --region $1"
fi

$command

