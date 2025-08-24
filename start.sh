#!/bin/sh

env

set -x

set_val() {
    if [ -n "$2" ]; then
        echo "set '$2' to '$1'"
        sed -i "s/<$2>[^<]*<\/$2>/<$2>$1<\/$2>/g" /etc/icecast2/icecast.xml
    else
        echo "Setting for '$1' is missing, skipping." >&2
    fi
}

set_val $ICECAST_SOURCE_PASSWORD source-password
set_val $ICECAST_RELAY_PASSWORD  relay-password
set_val $ICECAST_ADMIN_PASSWORD  admin-password
set_val $ICECAST_PASSWORD        password
set_val $ICECAST_HOSTNAME        hostname

 # ADD THESE NEW LINES FOR MOUNTPOINT PASSWORDS:
  if [ -n "$JAZZ_SOURCE_PASSWORD" ]; then
      echo "Setting Jazz source password"
      sed -i "s/\${JAZZ_SOURCE_PASSWORD}/$JAZZ_SOURCE_PASSWORD/g" /etc/icecast2/icecast.xml
  fi

  if [ -n "$ROCK_SOURCE_PASSWORD" ]; then
      echo "Setting Rock source password"
      sed -i "s/\${ROCK_SOURCE_PASSWORD}/$ROCK_SOURCE_PASSWORD/g" /etc/icecast2/icecast.xml
  fi

  set -e

  sudo -Eu icecast2 icecast2 -n -c /etc/icecast2/icecast.xml
