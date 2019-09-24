echo 'Setting OS Preferences'
source ../apps-and-preferences/macos_preferences.sh

echo 'Installing Core Dev Tools'
source ./core-dev-tools.sh

echo 'First Install Complete. Please Do The Following'
echo 'sudo xcodebuild -license accept'
echo 'mas login --prompt EMAIL'
echo 'open a  new window and run "source setup_part2.sh"'
