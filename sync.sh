#!/bin/bash

prefix=s3://www.bos-schweiz.ch

# create a temp file to hold html
tmp=$(mktemp --suffix=.html)

# MAPPING
# =======
# http://born2bewild.org         -> http://bos-schweiz.ch
# -----------------------------------------------------------------------------
# /com-dev/                      -> /de/entwicklung/nachhaltige-entwicklung.htm
# /com-dev/bildungsprojekte.html -> /de/entwicklung/bildungsprojekte.htm
# /com-dev/gesundheit.html       -> /de/entwicklung/gesundheit.htm
# /com-dev/mawas.html            -> /de/entwicklung/mawas.htm
# /com-dev/mikrokredit.html      -> /de/entwicklung/mikrokredit.htm

base='http://born2bewild.org/com-dev'
target='/de/entwicklung'

# retrieve html from primary hosting into temp file
wget -kO $tmp $base/

# convert specific links
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp

# upload temp file to secondary hosting via s3
aws s3 cp --acl public-read $tmp $prefix$target/nachhaltige-entwicklung.htm


# bildungsprojekte
wget -kO $tmp $base/bildungsprojekte.html
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp
sed -i "s|$base/#bildungsprojekte|$target.htm#bildungsprojekte|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/bildungsprojekte.htm

# gesundheit
wget -kO $tmp $base/gesundheit.html
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp
sed -i "s|$base/#gesundheit|$target.htm#gesundheit|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/gesundheit.htm

# mawas
wget -kO $tmp $base/mawas.html
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mikrokredit.html|$target/mikrokredit.htm|" $tmp
sed -i "s|$base/#mawas|$target.htm#mawas|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/mawas.htm

# mikrokredit
wget -kO $tmp $base/mikrokredit.html
sed -i "s|$base/bildungsprojekte.html|$target/bildungsprojekte.htm|" $tmp
sed -i "s|$base/gesundheit.html|$target/gesundheit.htm|" $tmp
sed -i "s|$base/mawas.html|$target/mawas.htm|" $tmp
sed -i "s|$base/#mikrokredit|$target.htm#mikrokredit|" $tmp
aws s3 cp --acl public-read $tmp $prefix$target/mikrokredit.htm


# remove temp file
rm $tmp

# send an email to local user root
echo "http://www.bos-schweiz.ch/de/entwicklung/nachhaltige-entwicklung.htm" \
    | mail -s "LP ComDev has been updated." root
