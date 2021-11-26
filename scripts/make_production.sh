#!/bin/bash

#DIR gets incremented before being copied over to production pubspec
DIR=/c/cp2dependencies/pubspec.yaml
PRODUCTION_PUBSPEC=/c/ncv-androidtv/flutter_exoplayer/nikonikotv/pubspec.yaml

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

copy_pubspec_to_prod() {
    echo "Initiate copying local pubspec to production directory..."
    echo "Looking for pubspec in production directory..."
    # Check existence of production pubspec at /c/cp2-androidtv-playpause_androidtv/flutter_exoplayer/nikonikotv/pubspec.yaml
    if test -f "$PRODUCTION_PUBSPEC"; then
        echo "${green}File production pubspec.yaml found${reset}"

        echo "Initiate increment local pubspec version by 1... "
        perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+\+)(\d+)$/$1.($2).($3+1)/e' $1
        echo "Done"
    else
        echo "${red}$PRODUCTION_PUBSPEC not found, exiting in case of bad errors${reset}"
        exit 2
    fi

    cp $DIR $PRODUCTION_PUBSPEC
}

copy_gradle_to_prod() {
    source copy_gradle.sh
}

establish_keystore() {
    source establish_keystore.sh
    echo "========================================="
    echo "Complete"
}

copy_pubspec_to_prod $DIR
copy_gradle_to_prod
establish_keystore