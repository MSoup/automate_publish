#!/bin/bash

# Directories
LOCAL_GRADLE=/c/cp2dependencies/nikonikotv-android-app/build.gradle
REPO_GRADLE=/c/ncv-androidtv/flutter_exoplayer/nikonikotv/android/app/build.gradle

# Setting up error display handling
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

#Current Date
_now=$(date +"%m_%d_%Y")

# Step 1: Check that production build.gradle exists
echo "Initiate copying gradle"
echo "Looking for build.gradle in $LOCAL_GRADLE"

if test -f "$LOCAL_GRADLE"; then
    echo "${green}Local build.gradle found, proceeding...${reset}"
else
    echo "${red}Error. Is there a $LOCAL_GRADLE file?${reset}"
    exit 1
fi

# Step 2: Check that repo gradle exists
BASE=${REPO_GRADLE##*/}   #=> "build.gradle" (basepath)
DIR=${REPO_GRADLE%$BASE}  #=> "(dirpath without the build.gradle part)"
OLD=build.gradle.BAK

if test -f "$REPO_GRADLE"; then
    echo "${green}Repository $BASE exists.${reset}"
    echo "Creating $_now$OLD"
    echo "Done"
    echo "Initiate backing up file..."
    mv $REPO_GRADLE $DIR$_now$OLD
    echo "Done"
else
    echo "${red}repo build.gradle not found, are you sure you have the right path?${reset}"
    echo "Checked $DIR"
    exit 3
fi

# Step 3: Copying
echo "Copying and overwriting..."
cp $LOCAL_GRADLE $DIR
echo "Done"

# Step 4: For debugging purposes, echo gradle status
echo ${green}Gradle copied to production${reset}