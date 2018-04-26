Private Openssl CA container

Example Command:

docker run -it -d -e PASSWORD=Password2 -e DOMAIN=example3.com -e PCASUBJECT=testCA3.example3.com -e REGION=us-west-2 --name catest walkerk1980/docker-private-ca /usr/local/bin/doitallforme.sh

ENV VARS:
PASSWORD is for the local CA private key password.
DOMAIN is for the subject of the local CA subject.
PCASUBJECT is for the AWS ACM Private CA subject.
REGION is for the AWS Region you would like your Private CA to be created in.
