#!/bin/bash

echo 1000 >ca/serial
echo '' >ca/index.txt
/usr/local/bin/createCA.sh

/usr/local/bin/createPCA.sh
/usr/local/bin/signPCA.sh

/bin/bash
