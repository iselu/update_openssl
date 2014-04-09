#!/bin/bash
set -e
openssl version
if [[ `openssl version` == 'OpenSSL 1.0.1g 7 Apr 2014' ]]
then
    echo "openssl is already new version"
    exit 2
fi
wget http://www.openssl.org/source/openssl-1.0.1g.tar.gz
tar -xzf openssl-1.0.1g.tar.gz
cd openssl-1.0.1g/
yum -y install zlib
./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared
make && make install
mv /usr/bin/openssl /usr/bin/openssl.old
mv /usr/include/openssl /usr/include/openssl.old
mv /usr/lib/libssl.so /usr/lib/libssl.so.bak
ln -s /usr/local/ssl/bin/openssl /usr/bin/openssl
ln -s /usr/local/ssl/include/openssl /usr/include/openssl
ln -s /usr/local/ssl/lib/libssl.so.1.0.0 /usr/lib/libssl.so
echo "/usr/local/ssl/lib" >> /etc/ld.so.conf
/sbin/ldconfig -v
/usr/bin/openssl version
