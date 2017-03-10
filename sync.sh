#!/bin/sh

prefix=s3://www.bos-schweiz.ch

# create a temp file to hold html
tmp=$(mktemp --suffix=.html)

# mapping
# https://b2bw.github.io/com-dev/ -> /de/nachhaltige-entwicklung.htm
# https://b2bw.github.io/com-dev/bildungsprojekte.html -> /de/bildungsprojekte.htm
# https://b2bw.github.io/com-dev/gesundheit.html -> /de/gesundheit.htm
# https://b2bw.github.io/com-dev/mawas.html -> /de/mawas.htm
# https://b2bw.github.io/com-dev/mikrokredit.html -> /de/mikrokredit.htm

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
