#!/bin/bash

prefix=s3://www.bos-schweiz.ch

# create a temp file to hold html
tmp=$(mktemp --suffix=.html)


# MAPPING
# -------
# http://born2bewild.org/com-dev/                      -> /de/nachhaltige-entwicklung.htm
# http://born2bewild.org/com-dev/bildungsprojekte.html -> /de/nachhaltige-entwicklung/bildungsprojekte.htm
# http://born2bewild.org/com-dev/gesundheit.html       -> /de/nachhaltige-entwicklung/gesundheit.htm
# http://born2bewild.org/com-dev/mawas.html            -> /de/nachhaltige-entwicklung/mawas.htm
# http://born2bewild.org/com-dev/mikrokredit.html      -> /de/nachhaltige-entwicklung/mikrokredit.htm


base='http://born2bewild.org/com-dev'
target='/de/nachhaltige-entwicklung'

# retrieve html from primary hosting into temp file
wget -kO $tmp $base/

# convert specific links
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp

# upload temp file to secondary hosting via s3
aws s3 cp --acl public-read $tmp $prefix$target.htm


# bildungsprojekte
wget -kO $tmp $base/bildungsprojekte.html
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp
sed -i "s|$base/|$target.htm|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/bildungsprojekte.htm

# gesundheit
wget -kO $tmp $base/gesundheit.html
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp
sed -i "s|$base/|$target.htm|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/gesundheit.htm

# mawas
wget -kO $tmp $base/mawas.html
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp
sed -i "s|$base/|$target.htm|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/mawas.htm

# mikrokredit
wget -kO $tmp $base/mikrokredit.html
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/|$target.htm|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/mikrokredit.htm


# remove temp file
rm $tmp

# send an email to local user root
echo "http://www.bos-schweiz.ch/de/nachhaltige-entwicklung.htm" \
    | mail -s "LP ComDev has been updated." root
