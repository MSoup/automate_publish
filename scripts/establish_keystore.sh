#!/bin/bash

# Directories
LOCAL_KEYSTORE_PROPERTIES=/c/cp2dependencies/keystoreProperties/keystore.properties
LOCAL_KEYS=/c/cp2dependencies/keys/cp2keystore.jks
REPO_KEYSTORE=/c/ncv-androidtv/flutter_exoplayer/nikonikotv/android/keystore.properties
REPO_KEYS=/c/ncv-androidtv/flutter_exoplayer/nikonikotv/android/app/cp2keystore.jks

# Setting up error display handling
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
# echo "${red}red text ${green}green text${reset}"

# Step 1: Check if keystore exists on repo
echo "Initiate establishing keystore files"

if test -f "$REPO_KEYSTORE" && test -f "$REPO_KEYS"; then
    echo "KEYSTORE and KEYS are in place, exiting..."
else
    echo "Either the keystore or the keys are missing. Continuing to establish links..."
    exit 4
fi

echo ${green}SUCCESS${reset}
