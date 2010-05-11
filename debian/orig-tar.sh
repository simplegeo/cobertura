#!/bin/sh 

set -x

# called by uscan with '--upstream-version' <version> <file>
echo "version $2"
package=`dpkg-parsechangelog | sed -n 's/^Source: //p'`
debian_version=`dpkg-parsechangelog | sed -ne 's/^Version: \(.*+dfsg\)-.*/\1/p'`
TAR="$package"_${debian_version}.orig.tar.gz
DIR=$package-${debian_version}.orig

# clean up the upstream tarball
tar xfz $3
mkdir $DIR
mv cobertura-*/* $DIR 
GZIP=--best tar -c -z -f $TAR --exclude '*.jar' --exclude 'lib/*'  --exclude 'etc/dtds/*' $DIR
rm -rf $3 ./$DIR cobertura-$2
