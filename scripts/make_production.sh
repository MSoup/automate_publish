#!/bin/bash

#Specify pubspec.yaml DIR here
DIR=/c/cp2dependencies/pubspec.yaml
PRODUCTION_PUBSPEC=/c/ncv-androidtv/flutter_exoplayer/nikonikotv/pubspec.yaml

# Check existence of /c/cp2dependencies/pubspec.yaml
if test -f "$DIR"; then
    echo "Pubspec.yaml found, proceeding..."
else
    echo "$DIR not found, exiting"
    exit 1
fi

# Increments build version by 1
increment_pubspec_version() {
    perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+\+)(\d+)$/$1.($2).($3+1)/e' $1
}

# 2. Copy gradle.build to production build
# Reason: gradle.build contains the code needed for flutter to know that it is a relase build

copy_pubspec_to_prod() {
    # Check existence of production pubspec at /c/cp2-androidtv-playpause_androidtv/flutter_exoplayer/nikonikotv/pubspec.yaml
    if test -f "$PRODUCTION_PUBSPEC"; then
        echo "Production pubspec.yaml found, proceeding..."
    else
        echo "$PRODUCTION_PUBSPEC not found, exiting"
        exit 2
    fi

    cp $DIR $PRODUCTION_PUBSPEC

}

copy_gradle_to_prod() {
    source copy_gradle.sh
}

increment_pubspec_version $DIR
copy_pubspec_to_prod
copy_gradle_to_prod