#! /bin/sh

set -e

ip(){
 if [ -z "$1" ]; then
    echo "Host params is required."
    return 1
 else
    host="$(getent hosts $1 | awk '{ print $1 }')"

    if [ -z $host ] ; then return 1 ; fi

    echo $host
 fi
}

if [ -n "$PHP_CONTAINER_HOST" ]; then
    CONF_FILE="/etc/lighttpd/conf-enabled/15-fastcgi-php.conf"
    if [ -e "$CONF_FILE" ] && grep -q '"host" => ".*"' $CONF_FILE ; then
    # "host": is ip of the FastCGI process (no support for hostnames right now)
    sed -i 's/"host" => ".*"/"host" => "'$(ip $PHP_CONTAINER_HOST)'"/' $CONF_FILE
    fi
fi

exec "$@"
