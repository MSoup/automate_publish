#!/bin/bash

#DIR gets incremented before being copied over to production pubspec
DIR=/c/cp2dependencies/pubspec.yaml
PRODUCTION_PUBSPEC=/c/git/cp2-androidtv/nikonikotv/pubspec.yaml

# Setting up error display handling
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

# Starting script
echo "========================================="
echo "Starting main script:"


echo "Initiate search for /c/cp2dependencies/pubspec.yaml"
# Check existence of /c/cp2dependencies/pubspec.yaml
if test -f "$DIR"; then
    echo "${green}File pubspec.yaml found, proceeding...${reset}"
else
    echo "${red}$DIR not found, exiting ${reset}"
    exit 1
fi

# Copy pubspec.yaml to prod
# Reason: ver. needs to be incremented by +1
copy_pubspec_to_prod() {
    echo "Initiate copying local pubspec to production directory..."
    echo "Looking for pubspec in production directory..."
    # Check existence of production pubspec at /c/git/cp2-androidtv/nikonikotv/pubspec.yaml
    if test -f "$PRODUCTION_PUBSPEC"; then
        echo "${green}File production pubspec.yaml found${reset}"

        echo "Initiate increment local pubspec version by 1... "
        python updateVersion.py $DIR
        echo "Copying..."
        cp $DIR $PRODUCTION_PUBSPEC
        echo "Done"
    else
        echo "${red}$PRODUCTION_PUBSPEC not found, exiting in case of bad errors${reset}"
        exit 2
    fi

    
}

# Copy gradle to prod
# Reason: gradle needs to have release signing config for Google to allow to app store
copy_gradle_to_prod() {
    source copy_gradle.sh
}

# Call establish_keystore.sh script
establish_keystore() {
    source establish_keystore.sh
    echo "========================================="
    echo "Complete"
}

# build from repo with everything in place
build() {
    echo "Attempting to build..."
    cd /c/git/cp2-androidtv/nikonikotv
    flutter build appbundle
    echo "Complete"
    exit 0
}

copy_pubspec_to_prod $DIR
copy_gradle_to_prod
establish_keystore
build