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
command+=" --certificate-authority-type SUBORDINATE" 
command+=" --idempotency-token $random_token"
command+=" --query CertificateAuthorityArn --output text"

if [ ! -z "$1" ];then
 command+=" --region $1"
fi

pca_arn=$($command)

echo -e "\n\rCreated PCA with CertificateAuthorityArn: $pca_arn\n\n"
echo -en "$pca_arn" >/root/pca/pca_arn.txt

if [ ! -z "$1" ];then
 echo -en "$1" >/root/pca/pca_region.txt
fi
