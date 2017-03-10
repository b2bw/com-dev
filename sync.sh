#!/bin/sh

prefix=s3://www.bos-schweiz.ch

# create a temp file to hold html
tmp=$(mktemp --suffix=.html)

# mapping
# https://b2bw.github.io/com-dev/ -> /de/nachhaltige-entwicklung.htm
# https://b2bw.github.io/com-dev/ost-kalimantan.html -> /de/ost-kalimantan.htm
# https://b2bw.github.io/com-dev/salat-island.html -> /de/salat-island.htm
# https://b2bw.github.io/com-dev/technische-detail.html -> /de/technische-details.htm

# retrieve html from primary hosting into temp file
wget -kO $tmp https://b2bw.github.io/com-dev/

# upload temp file to secondary hosting via s3
aws s3 cp --acl public-read $tmp \
    $prefix/de/nachhaltige-entwicklung.htm

# remove temp file
rm $tmp

# send an email to local user root
echo "http://www.bos-schweiz.ch/de/nachhaltige-entwicklung.htm" \
    | mail -s "LP ComDev has been updated." root
