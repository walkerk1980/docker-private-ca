FROM ubuntu
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --assume-yes -y --yes -f dist-upgrade
RUN apt-get install -y openssl dnsutils nano tcpdump screen tmux
WORKDIR /root/
RUN mkdir ca && cd ca && mkdir certs csr private crl newcerts && chmod 700 private && touch index.txt && echo 1000 >serial
COPY openssl_root.cnf /root/ca/openssl_root.cnf
WORKDIR /root/ca/
ENV PASSWORD=Password1
RUN /bin/bash -c '/bin/echo -e "$PASSWORD\n\r" | openssl genrsa -aes256 -out private/root_private_key.pem -passout stdin && chmod 400 private/root_private_key.pem'
RUN /bin/bash -c '/bin/echo -e "$PASSWORD\n\r" | openssl req -config openssl_root.cnf -key private/root_private_key.pem -passin stdin -new -x509 -days 365 -sha256 -extensions v3_ca -out certs/ca_cert.pem -subj "/C=US/ST=Washington/L=Seattle/O=ExampleCompany/CN=www.example.com"'
