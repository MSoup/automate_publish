#!/bin/bash

# GET ALL ENV VARIABLES
source import_env_var.sh

# Globals:
# LOCAL_DIR: The pubspec.yaml to be incremented and moved to production (dependencies pubspec.yaml)
# PRODUCTION_PUBSPEC: The pubspec.yaml to be replaced

# Setting up error display handling
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Starting script
echo "========================================="
echo "Starting main script:"

echo "Initiate search for local copy of pubspec.yaml"

if test -f "$LOCAL_DIR"; then
    echo "${green}File pubspec.yaml found, proceeding...${reset}"
else
    echo "${red}$LOCAL_DIR not found, exiting ${reset}"
    exit 1
fi

# Copy pubspec.yaml to prod
# Reason: ver. needs to be incremented by +1
copy_pubspec() {
    echo "Initiate copying local pubspec to production directory..."
    echo "Looking for pubspec in production directory..."
    # Check existence of production repo pubspec
    if test -f "$PRODUCTION_PUBSPEC"; then
        echo "${green}File production pubspec.yaml found${reset}"

        echo "Initiate increment local pubspec version by 1... "
        python updateVersion.py $LOCAL_DIR

        echo "Copying..."
        cp $LOCAL_DIR $PRODUCTION_PUBSPEC

        echo "Done"
    else
        echo "${red}$PRODUCTION_PUBSPEC not found, exiting in case of bad errors${reset}"
        exit 2
    fi
}

# Copy local file with release config set
copy_gradle() {
    source copy_gradle.sh
}

# Signing keys validation checks
establish_keystore() {
    source establish_keystore.sh
    echo "========================================="
    echo "Complete"
}

# If everything else passes, build from repo
build() {
    echo "Attempting to build..."
    cd $FLUTTER_BUILD_PATH
    flutter build appbundle
    echo "Complete"
    exit 0
}

copy_pubspec $LOCAL_DIR
copy_gradle
establish_keystore
build