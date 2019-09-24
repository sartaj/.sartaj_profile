echo 'Setting OS Preferences'
source ../apps-and-preferences/macos_preferences.sh

echo 'Installing Core Dev Tools'
source ./download-cli-package-managers.sh

echo 'First Install Complete. Please Do The Following'
echo 'sudo xcodebuild -license accept'
echo 'mas login --prompt EMAIL'
echo 'open a  new window and run "source ~/.sartaj_profile/setup/part2.sh"'
