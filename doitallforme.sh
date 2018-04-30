#!/bin/bash

echo 1000 >ca/serial
echo '' >ca/index.txt
/usr/local/bin/createCA.sh

/usr/local/bin/createPCA.sh
/bin/echo -e "\n\rSleeping 10 seconds to allow PCA creation to finish\n\r"
sleep 10
/usr/local/bin/signPCA.sh

/bin/bash
