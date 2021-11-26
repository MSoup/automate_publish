#!/bin/bash

PRODUCTION_GRADLE=/c/cp2dependencies/nikonikotv-android-app/build.gradle
REPO_GRADLE=/c/ncv-androidtv/flutter_exoplayer/nikonikotv/android/app/build.gradle

#Current Date
_now=$(date +"%m_%d_%Y")

# Step 1: Check that production build.gradle exists
echo "Copying gradle"
echo "Looking for build.gradle in $PRODUCTION_GRADLE"

if test -f "$PRODUCTION_GRADLE"; then
    echo "File found, proceeding..."
else
    echo "Error. Is there a $PRODUCTION_GRADLE file?"
    exit 1
fi

# Step 2: Check that repo gradle exists
BASE=${REPO_GRADLE##*/}   #=> "build.gradle" (basepath)
DIR=${REPO_GRADLE%$BASE}  #=> "/c/cp2-androidtv-playpause_androidtv/flutter_exoplayer/nikonikotv/android/app/" (dirpath)
OLD=build.gradle.BAK

if test -f "$REPO_GRADLE"; then
    echo "$BASE exists. Creating $_now$OLD"
    mv $REPO_GRADLE $DIR$_now$OLD
else
    echo "repo build.gradle not found, are you sure you have the right path?"
    echo "Checked /c/cp2-androidtv-playpause_androidtv/flutter_exoplayer/nikonikotv/android/app/"
    exit 3
fi

# Step 3: Copying
echo "Copying and overwriting..."
cp $PRODUCTION_GRADLE $DIR

# Step 4: For debugging purposes, echo gradle status
MATCH=*.gradle
ls -ltr $DIR$MATCH