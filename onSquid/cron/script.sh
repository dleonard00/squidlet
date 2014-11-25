#!/bin/bash

function rollback {
    DIRECTORY="/etc/lastValidSquidConfig"

    if [ ! -d "$DIRECTORY" ]; then
      echo "FATAL - No backup config exists - or there is an error in this scri$
    fi

    sudo rsync -v --delete -r /etc/lastValidSquidConfig/squid3/ /etc/squid3/
# This is where we need to send an alert email
}

function updateLastWorkingConfig {
    DIRECTORY="/etc/lastValidSquidConfig"

    if [ ! -d "$DIRECTORY" ]; then
        mkdir -p $DIRECTORY
      echo " Control will enter here if $DIRECTORY exists."
    fi

    sudo rsync -v --delete -r /etc/squid3 /etc/lastValidSquidConfig
}

parse_output=$(sudo squid -k parse)
if [[ $? != 0 ]]
then
    echo "FAILED sudo squid -k parse"
elif [[ -n $($parse_output | grep FATAL) ]]
then
    echo "FATAL Exception sudo squid -k parse"
    rollback
else
    echo "SUCCESS sudo squid -k parse"

    if [[ -n $(sudo squid -k reconfigure) ]]
    then
        echo "FAILED sudo squid -k reconfigure"
        rollback
    else
        echo "SUCCESS sudo squid -k reconfigure"

        if [[ -n $(sudo squid -k check) ]]
        then
            echo "FAILED sudo squid -k check"
            rollback
        else
            echo "SUCCESS sudo squid -k check"
            updateLastWorkingConfig
# this is where we want to roll back to the last valid config and send alert email

        fi

    fi

fi
