# automate_publish
Automating the pushlishing from a local machine to a state ready for the Google playstore

I got sick of having to 

- manually edit build.gradle
- change settings from dev to release
- check the existence of a pubspec file
- update the version number in my pubspec.yaml file
- and make sure that my signing keys exist and match what Google expects me to upload.

So... I automated the entire thing down to packaging the appbundle.
