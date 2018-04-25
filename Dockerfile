FROM ubuntu
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --assume-yes -y --yes -f dist-upgrade
RUN apt-get install -y openssl dnsutils nano tcpdump screen tmux
WORKDIR /root/
COPY ca /root/ca
COPY ca/certs/ ca/crl/  ca/csr/  ca/index.txt  ca/newcerts/  ca/private/  ca/serial/ /root/ca/
COPY openssl_root.cnf /root/ca/openssl_root.cnf
WORKDIR /root/ca/
ENV PASSWORD=Password1
ENV DOMAIN=example.com
COPY startup.sh /usr/local/bin/startup.sh
COPY createCA.sh /usr/local/bin/createCA.sh
COPY cainfo.sh /usr/local/bin/cainfo.sh
RUN /usr/local/bin/createCA.sh
