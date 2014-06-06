#!/bin/bash
set -e

update_0.9.8(){
	if [[ `openssl version` == 'OpenSSL 0.9.8za 5 Jun 2014' ]]
	then
	    echo "Update openssl to 0.9.8za 5 Jun 2014"
	    exit 2
	fi
	echo "You openssl version"
	openssl version
	wget www.openssl.org/source/openssl-0.9.8za.tar.gz
	tar zxf openssl-0.9.8za.tar.gz
	cd openssl-0.9.8za/
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
	echo "Now openssl version"
	/usr/bin/openssl version
}

update_1.0.1(){
	if [[ `openssl version` == 'OpenSSL 1.0.1g 7 Apr 2014' ]]
	then
	    echo "Update openssl to 1.0.1g 7 Apr 2014"
	    exit 2
	fi
	echo "You openssl version"
	openssl version
	wget http://www.openssl.org/source/openssl-1.0.1g.tar.gz
	tar -xzf openssl-1.0.1g.tar.gz
	cd openssl-1.0.1g/
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
	echo "Now openssl version"
	/usr/bin/openssl version
}

if [[ $1 == '0.9.8' ]]; then
	update_0.9.8
fi

if [[ $1 == '1.0.1' ]]; then
	update_1.0.1
fi