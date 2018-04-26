#!/bin/bash

random-token()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-20} | head -n 1
}

caconfig=/root/pca/pca_config.json
revokecfg=/root/pca/pca_revoke_config.json
random_token=$(random-token)

aws acm-pca create-certificate-authority \
--certificate-authority-configuration file://$caconfig \
--revocation-configuration file://$revokecfg \
--certificate-authority-type "SUBORDINATE" \
--idempotency-token $random_token
