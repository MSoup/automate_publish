#!/bin/bash

# Setting up error display handling
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
flag="false"

# Step 1: Check if keystore exists on repo
echo "Initiate establishing keystore files"
if test -f "$LOCAL_KEYSTORE_PROPERTIES" && test -f "$LOCAL_KEYS"; then
    echo "LOCAL KEYSTORE and KEYS are in place, proceeding..."
    flag="true"
else
    echo "No local keystore/keys to copy, over this might be a problem if production doesn't have them either"
fi


if test -f "$REPO_KEYSTORE_PROPERTIES" && test -f "$REPO_KEYS"; then
    echo "Production KEYSTORE and KEYS are in place, exiting..."
else
    echo "Either the keystore or the keys are missing. Continuing to establish links..."
    if flag=="true"; then
        cp $LOCAL_KEYSTORE_PROPERTIES $REPO_KEYSTORE_PROPERTIES
        cp $LOCAL_KEYS $REPO_KEYS
    else
        echo "No local keystore, no prod keystore OR"
        echo "No local keys, no prod keys"
        echo "Unable to move signing keys for Google-sensei"
        exit 4
    fi
fi

echo ${green}SUCCESS${reset}
