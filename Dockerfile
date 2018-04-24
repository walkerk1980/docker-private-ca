FROM ubuntu
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confnew" --assume-yes -y --yes -f dist-upgrade
RUN apt-get install -y openssl dnsutils nano tcpdump screen tmux
WORKDIR /root/
RUN mkdir ca && cd ca && mkdir certs csr private crl newcerts && chmod 700 private && touch index.txt && echo 1000 >serial
COPY openssl_root.cnf /root/ca/openssl_root.cnf
WORKDIR /root/ca/
ENV PASSWORD=Password1
COPY createCA.sh /usr/local/bin/createCA.sh
RUN chmod +x /usr/local/bin/createCA.sh
RUN /usr/local/bin/createCA.sh
