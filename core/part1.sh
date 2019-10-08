SOURCE=${(%):-%N}
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo 'Setting OS Preferences'
source $DIR/../apps-and-preferences/macos_preferences.sh

echo 'Installing Core Dev Tools'
source $DIR/download-cli-package-managers.sh

echo 'First Install Complete. Please Do The Following'
# echo 'sudo xcodebuild -license accept'
echo 'mas signin you@example.com'
echo 'open a  new window and run "source ~/.sartaj_profile/core/part2.sh"'
