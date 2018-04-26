#!/bin/bash

pca_arn=$(cat /root/pca/pca_arn.txt)

command="aws acm-pca get-certificate-authority-csr"
command+=" --certificate-authority-arn $pca_arn"
command+=" --output text"

if [ ! -z "$(cat /root/pca/pca_region.txt 2>/dev/null)" ];then
 command+=" --region $(cat /root/pca/pca_region.txt)"
fi

pca_csr=$($command)

echo $pca_csr|cut -d' ' -f'-3' >/root/ca/csr/pca.csr
echo $pca_csr|cut -d' ' -f'4-100'|rev|cut -d' ' -f'4-100'|rev|sed 's/ /\r\n/g' >>/root/ca/csr/pca.csr
echo $pca_csr|rev|cut -d' ' -f'-3'|rev >>/root/ca/csr/pca.csr

/bin/echo -e "$PASSWORD\n\r"|/usr/bin/openssl ca \
-config /root/ca/openssl_root.cnf \
-extensions v3_intermediate_ca -days 3650 \
-notext -md sha256 \
-in /root/ca/csr/pca.csr -out /root/ca/certs/pca.pem \
-passin stdin -batch

command="aws acm-pca import-certificate-authority-certificate"
command+=" --certificate-authority-arn $pca_arn"
command+=" --certificate file:///root/ca/certs/pca.pem"
command+=" --certificate-chain file:///root/ca/certs/ca.pem"

if [ ! -z "$(cat /root/pca/pca_region.txt 2>/dev/null)" ];then
 command+=" --region $(cat /root/pca/pca_region.txt)"
fi

$command
