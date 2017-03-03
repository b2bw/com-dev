#!/bin/sh

prefix=s3://www.bos-schweiz.ch

# 1. create a temp file to hold html
tmp=$(mktemp --suffix=.html)

# 2. retrieve html from primary hosting into temp file
curl -o $tmp https://b2bw.github.io/com-dev/

# 3. upload temp file to secondary hosting via s3
aws s3 cp --acl public-read $tmp \
    $prefix/de/projekte/entwicklungszusammenarbeit.htm

# 4. remove temp file
rm $tmp





# 5. send an email to local user root
echo "http://www.bos-schweiz.ch/de/projekte/entwicklungszusammenarbeit.htm" \
    | mail -s "ComDev has been updated." root
