#!/bin/bash
cd /root/ca/

/bin/echo -e "$PASSWORD\n\r" | openssl genrsa -aes256 -out private/root_private_key.pem -passout stdin && chmod 400 private/root_private_key.pem
/bin/echo -e "$PASSWORD\n\r" | openssl req -config openssl_root.cnf -key private/root_private_key.pem -passin stdin -new -x509 -days 365 -sha256 -extensions v3_ca -out certs/ca_cert.pem -subj "/C=US/ST=Washington/L=Seattle/O=ExampleCompany/CN=www.example.com"